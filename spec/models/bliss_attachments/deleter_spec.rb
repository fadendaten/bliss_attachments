require 'spec_helper'

describe BlissAttachments::Deleter do
  subject { double('object_with_attachmets').extend BlissAttachments::Deleter }

  describe "#delete_<attachment>" do
    it "should exist if given object has many <attachment>s of type Attachment" do
      subject.stub(:delivery_examples).and_return(
        [BlissAttachments::Attachment.new]
      )
      subject.should respond_to :delete_delivery_example
    end

    it "should not exist if <attachment> is not of type Attachment" do
      subject.stub(:orders).and_return(
        [:im_not_an_attachment, :me_neither]
      )
      subject.should_not respond_to :delete_order
    end

    it "should delete the attachment that refers to a file at given file path" do
      file_name = 'file.jpg'
      file_path = "/system/bliss_attachments/attachments/files//large/#{file_name}"
      attachment_to_delete =
        BlissAttachments::Attachment.new :file_file_name => file_name

      some_other_attachment =
        BlissAttachments::Attachment.new :file_file_name => "other_file.jpg"

      subject.stub(:sketches).and_return(
        [attachment_to_delete, some_other_attachment]
      )

      subject.delete_sketch file_path
      attachment_to_delete.should be_destroyed
      some_other_attachment.should_not be_destroyed
    end

    it "should ignore the appended cache key when deleting attachments" do
      file_path_without_cache_key =
        "/system/bliss_attachments/attachments/files//large/file.jpg"

      file_path_with_cache_key = file_path_without_cache_key + '?1234'

      attachment_to_delete =
        BlissAttachments::Attachment.new :file_file_name => 'file.jpg'

      subject.stub(:sketches).and_return(
        [attachment_to_delete]
      )

      subject.delete_sketch file_path_with_cache_key
      attachment_to_delete.should be_destroyed
    end
  end
end

