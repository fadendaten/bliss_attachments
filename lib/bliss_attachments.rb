require "bliss_attachments/engine"

module BlissAttachments
  class Config
    attr_accessor :default_url
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end
end
