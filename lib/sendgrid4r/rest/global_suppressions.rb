# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Asm
      module GlobalSuppressions

        include SendGrid4r::REST::Request

        def post_global_suppressed_emails(recipient_emails)
          params = Hash.new
          params["recipient_emails"] = recipient_emails
          response = post(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/global", params.to_hash)
          recipient_emails = response["recipient_emails"]
          recipient_emails
        end

        def get_global_suppressed_email(email_address)
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/global/#{email_address}")
          email_address = response["recipient_email"]
          email_address
        end

        def delete_global_suppressed_email(email_address)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/global/#{email_address}")
        end

      end
    end

  end
end
