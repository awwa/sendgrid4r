# -*- encoding: utf-8 -*-

require 'base64'

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    Attachment = Struct.new(
      :content, :filename, :type, :disposition, :content_id
    ) do
      def set_content(content)
        self[:content] = Base64.strict_encode64(content)
        self
      end

      def set_filename(filename)
        self[:filename] = filename
        self
      end

      def set_type(type)
        self[:type] = type
        self
      end

      def set_disposition(disposition)
        self[:disposition] = disposition
        self
      end

      def set_content_id(content_id)
        self[:content_id] = content_id
        self
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
