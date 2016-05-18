# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 MailFactory implementation
    #
    module MailFactory
      def self.create_params(personalizations:, from:, contents:)
        params = SendGrid4r::REST::Mail::Params.new(
          nil, nil, nil,
          nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
        )
        params
          .set_personalizations(personalizations)
          .set_from(from)
          .set_contents(contents)
      end

      def self.create_email(email:, name: nil)
        SendGrid4r::REST::Mail::Email.new(email, name)
      end

      def self.create_personalization(tos:, subject:)
        per = SendGrid4r::REST::Mail::Personalization.new(
          nil, nil, nil, nil, nil, nil, nil, nil
        )
        per
          .set_tos(tos)
          .set_subject(subject)
      end

      def self.create_attachment(content:, filename:)
        attachment = SendGrid4r::REST::Mail::Attachment.new(
          nil, nil, nil, nil, nil
        )
        attachment
          .set_content(content)
          .set_filename(filename)
      end

      def self.create_mail_settings
        SendGrid4r::REST::Mail::MailSettings.new(nil, nil, nil, nil, nil)
      end

      def self.create_tracking_settings
        SendGrid4r::REST::Mail::TrackingSettings.new(nil, nil, nil, nil)
      end

      def self.create_content(type:, value:)
        SendGrid4r::REST::Mail::Content.new(type, value)
      end
    end
  end
end
