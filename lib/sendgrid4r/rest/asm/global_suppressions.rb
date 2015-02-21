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
          url = "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/global"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def post_global_suppressed_emails(recipient_emails)
          params = { recipient_emails: recipient_emails }
          resp = post(
            @auth,
            SendGrid4r::REST::Asm::GlobalSuppressions.url,
            params
          )
          resp['recipient_emails']
        end

        def get_global_suppressed_email(email_address)
          resp = get(
            @auth,
            SendGrid4r::REST::Asm::GlobalSuppressions.url(email_address)
          )
          resp['recipient_email']
        end

        def delete_global_suppressed_email(email_address)
          delete(
            @auth, SendGrid4r::REST::Asm::GlobalSuppressions.url(email_address))
        end
      end
    end
  end
end
