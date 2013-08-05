require 'spec_helper'

describe BlissAttachments::Attachment do
  describe "#type" do
    it { should respond_to :type }
  end
end
