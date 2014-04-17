module BlissAttachments
  class Attachment < ActiveRecord::Base
    attr_accessible :parent_type, :parent_id, :file, :file_file_name,
      :file_content_type, :file_file_size, :type, :favourited

    belongs_to :parent, :polymorphic => true

    has_attached_file :file,
      :styles      => {:large => "500x500", :medium => "150x150", :thumb => "75x100"},
      :default_url => "/system/missing_thumb.png"
  end

  class ImageAttachment < Attachment
    validates_attachment :file,
      :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/tiff", "image/png"] }

    has_attached_file :file,
      :styles      => { :original => {:geometry => "100%", :format => "png"},
                        :large => {:geometry => "500x500", :format => "png"},
                        :medium => {:geometry => "150x150", :format => "png"},
                        :thumb => {:geometry => "75x100", :format => "png"}
                      },
      :default_url => "/system/missing_thumb.png"
  end
end
