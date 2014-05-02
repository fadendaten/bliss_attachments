module BlissAttachments
  class ImageAttachment < Attachment
    after_post_process :overwrite_content_type_file_name

    has_attached_file :file,
                      :styles      => { :original => {:geometry => "100%", :format => "png"},
                                        :large => {:geometry => "500x500", :format => "png"},
                                        :medium => {:geometry => "150x150", :format => "png"},
                                        :thumb => {:geometry => "75x100", :format => "png"}
                      },
                      :default_url => "/system/missing_thumb.png"

    validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/tiff", "image/png"]

    private

    def overwrite_content_type_file_name
      new_file_name = (self.file_file_name.split /\./).first
      new_file_name += ".png"
      self.file_file_name = new_file_name
      self.file_content_type = "image/png"
    end


  end
end