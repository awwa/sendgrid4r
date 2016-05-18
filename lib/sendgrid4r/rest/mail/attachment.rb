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
        tap { |s| s[:content] = Base64.strict_encode64(content) }
      end

      def set_filename(filename)
        tap { |s| s[:filename] = filename }
      end

      def set_type(type)
        tap { |s| s[:type] = type }
      end

      def set_disposition(disposition)
        tap { |s| s[:disposition] = disposition }
      end

      def set_content_id(content_id)
        tap { |s| s[:content_id] = content_id }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
