module Paperclip
  class FileContents
    def initialize file, options = {}, attachment = nil
      puts "see im in but im way too lazy to perform shit"
      
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @current_format = File.extname(attachment.instance.asset_file_name)
      @basename       = File.basename(@file.path, @current_format)
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make
      begin
        if(@instance.new_record?)
          @file.rewind # move pointer back to start of file in case handled by other processors
          file_content = File.read(@file.path)
          @instance.send("#{@options[:contents]}=", file_content)
        else                                                     
          # existing record, set contents by reading contents attribute
          file_content = @instance.send(@options[:contents])
          # create new file with contents from model
          tmp = Tempfile.new([@basename, @current_format].compact.join("."))
          tmp << file_content
          tmp.flush 
          @file = tmp
        end               
        @file
      rescue StandardError => e
        raise PaperclipError, "There was an error processing the file contents for #{@basename} - #{e}" if @whiny
      end
    end
    
  end
end