module BlissAttachments
  class Attachment < ActiveRecord::Base
    attr_accessible :parent_type, :parent_id, :file, :file_file_name,
      :file_content_type, :file_file_size, :type, :favourited

    belongs_to :parent, :polymorphic => true
    has_attached_file :file,
                      :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/tiff", "image/png"] },
                      :styles      => {:large => "500x500", :medium => "150x150", :thumb => "75x100"},
                      :default_url => BlissAttachments.config.default_url

    validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/tiff", "image/png"]



  end
end
