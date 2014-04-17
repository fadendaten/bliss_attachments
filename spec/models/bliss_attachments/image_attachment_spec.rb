require 'spec_helper'

describe BlissAttachments::ImageAttachment, :focus => true do
  let(:attachment_class) { BlissAttachments::ImageAttachment }
  def test_file(extension)
    File.new(Rails.root + "spec/fixtures/images/test#{extension}")
  end

  describe "upload" do

    describe "validations" do
      it "should allow .jpg" do
        attachment = attachment_class.new :file => test_file(".jpg")
        attachment.should be_valid
      end

      it "should allow .png" do
        attachment = attachment_class.new :file => test_file(".png")
        attachment.should be_valid
      end

      it "should allow .tiff" do
        attachment = attachment_class.new :file => test_file(".tiff")
        attachment.should be_valid
      end

      it "should not allow .pdf" do
        attachment = attachment_class.new :file => test_file(".pdf")
        attachment.should_not be_valid
      end
    end

    describe "converting" do
      it "should convert all image types to .png" do
        attachment = attachment_class.create :file => test_file(".tiff")
        raise attachment.inspect
        attachment.file_content_type.should == "image/png"
      end
    end
  end
end

