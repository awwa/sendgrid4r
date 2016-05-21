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
      def content=(content)
        tap { |s| s[:content] = Base64.strict_encode64(content) }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
