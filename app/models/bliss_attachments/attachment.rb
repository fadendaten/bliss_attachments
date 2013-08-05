module BlissAttachments
  class Attachment < ActiveRecord::Base
    attr_accessible :parent_type, :parent_id, :file_file_name, :type, :favourited
    belongs_to :parent, :polymorphic => true

    has_attached_file :file,
      :styles      => {:large => "500x500", :medium => "150x150", :thumb => "75x100"}, 
      :default_url => "/system/missing_thumb.png"
  end
end
