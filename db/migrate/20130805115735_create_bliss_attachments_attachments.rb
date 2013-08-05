class CreateBlissAttachmentsAttachments < ActiveRecord::Migration
  def change
    create_table :bliss_attachments_attachments do |t|
      t.integer  "parent_id"
      t.string   "parent_type"
      t.datetime "created_at",                           :null => false
      t.datetime "updated_at",                           :null => false
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.datetime "file_updated_at"
      t.string   "type"
      t.boolean  "favourited",        :default => false
      t.attachment "file"
      t.timestamps
    end
    add_index "bliss_attachments_attachments", ["parent_id", "parent_type"], :name => "index_attachments_on_parent_id_and_parent_type"
  end
end
