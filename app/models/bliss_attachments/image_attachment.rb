module BlissAttachments
  class ImageAttachment < Attachment  
    has_attached_file :file,
                      :styles      => { :original => {:geometry => "100%", :format => "png"},
                                        :large => {:geometry => "500x500", :format => "png"},
                                        :medium => {:geometry => "150x150", :format => "png"},
                                        :thumb => {:geometry => "75x100", :format => "png"}
                      },
                      :default_url => "/system/missing_thumb.png"
                      
    validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/tiff", "image/png"]         
  end
end