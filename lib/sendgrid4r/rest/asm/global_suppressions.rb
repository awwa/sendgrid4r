# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Asm
      #
      # SendGrid Web API v3 Advanced Suppression Manager - Global Suppressions
      #
      module GlobalSuppressions
        include SendGrid4r::REST::Request

        def self.url(email_address = nil)
          url = "#{BASE_URL}/asm/suppressions/global"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def post_global_suppressed_emails(recipient_emails, &block)
          params = { recipient_emails: recipient_emails }
          endpoint = SendGrid4r::REST::Asm::GlobalSuppressions.url
          resp = post(@auth, endpoint, params, &block)
          SendGrid4r::REST::Asm.create_recipient_emails(resp)
        end

        def get_global_suppressed_email(email_address, &block)
          endpoint =
            SendGrid4r::REST::Asm::GlobalSuppressions.url(email_address)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Asm.create_recipient_email(resp)
        end

        def delete_global_suppressed_email(email_address, &block)
          endpoint =
            SendGrid4r::REST::Asm::GlobalSuppressions.url(email_address)
          delete(@auth, endpoint, &block)
        end
      end
    end
  end
end
