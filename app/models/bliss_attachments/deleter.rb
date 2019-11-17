module BlissAttachments
  # We're using fotorama.js for displaying Attachments in a diashow.
  # The only way to tell the server which Attachment is currently
  # displayed is to submit the file path (apparently fotorama does
  # not work correctly if the user wants to provide other
  # identification in the view). This module was extracted from the
  # model that acts as a container for said attachments to handle
  # their deletion.
  # The Deleter responds to methods of form
  # #delete_<attachment> that take the file path as an argument.
  # It ignores the cache key at the end of the path name.
  #
  # ==== Examples
  #    class Style < ActiveRecord::Base
  #      include BlissAttachments::Deleter
  #    end
  #
  #    style.respond_to? :delivery_examples
  #    # => true
  #
  #    style.delete_delivery_example 'some/path/to/example.jpg?12345'
  module Deleter
    def method_missing(meth, *args, &block)
      if delete_attachment_method? meth
        attachments = send association_method_name(meth)
        destroy_attachment attachments, args.first
      else
        super
      end
    end

    def respond_to?(meth, include_private=false)
      delete_attachment_method?(meth) || super
    end

    private
    def destroy_attachment(attachments, file_path)
      attachment = attachments
        .find { |a| a.file.url(:large, false) == without_cache_key(file_path) }
      return if attachment.nil?

      attachment.destroy
    end

    def without_cache_key(file_path)
      if (file_path_without_cache_key = file_path[/(.+)\?\d+$/, 1])
        file_path_without_cache_key
      else
        file_path
      end
    end

    def delete_attachment_method?(meth)
      return false unless meth.to_s.starts_with?('delete_')
      association_meth = association_method_name meth
      begin
        collection = send association_meth
        attachments?(collection)
      rescue NoMethodError
        false
      end
    end

    def attachments?(collection)
      # Doesn't matter if relation or Array
      if collection.any?
        collection.first.is_a? Attachment
      else
        collection.new.is_a? Attachment
      end
    end

    def association_method_name(meth)
      meth[/^delete_(.+)/, 1].pluralize
    end
  end
end
