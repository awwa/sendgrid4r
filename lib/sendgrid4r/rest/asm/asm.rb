# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Advanced Suppression Manager
    #
    module Asm
      include SendGrid4r::REST::Request

      RecipientEmails = Struct.new(:recipient_emails)
      RecipientEmail = Struct.new(:recipient_email)

      def self.create_recipient_emails(resp)
        return resp if resp.nil?
        RecipientEmails.new(resp['recipient_emails'])
      end

      def self.create_recipient_email(resp)
        return resp if resp.nil?
        RecipientEmail.new(resp['recipient_email'])
      end
    end
  end
end
