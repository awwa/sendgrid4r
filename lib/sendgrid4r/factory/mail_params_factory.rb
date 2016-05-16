# -*- encoding: utf-8 -*-

require 'base64'

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Segment Factory Class implementation
    #
    module MailParamsFactory
      def self.create_params(personalizations:, from:, contents:)
        SendGrid4r::REST::Mail::Params.new(
          personalizations, from, contents,
          nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
        )
      end

      def self.create_email(email:, name: nil)
        SendGrid4r::REST::Mail::Email.new(email, name)
      end

      def self.create_personalization(tos:, subject:)
        SendGrid4r::REST::Mail::Personalization.new(
          tos, subject, nil, nil, nil, nil, nil, nil
        )
      end

      def self.create_attachment(content:, filename:)
        SendGrid4r::REST::Mail::Attachment.new(
          Base64.strict_encode64(content), filename, nil, nil, nil
        )
      end

      def self.create_mail_settings
        SendGrid4r::REST::Mail::MailSettings.new(nil, nil, nil, nil, nil)
      end

      def self.create_tracking_settings
        SendGrid4r::REST::Mail::TrackingSettings.new(nil, nil, nil, nil)
      end
    end
  end
end
