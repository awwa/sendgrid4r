# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Asm

      Suppression = Struct.new(:id, :name, :description, :suppressed)

      module Suppressions

        include SendGrid4r::REST::Request

        def get_suppressions(email_address)
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/#{email_address}")
          suppressions = Array.new
          resp_a["suppressions"].each{|resp|
            suppression = Suppression.new(
              resp["id"], resp["name"], resp["description"], resp["suppressed"])
            suppressions.push(suppression)
          }
          suppressions
        end

        def get_suppressed_emails(group_id)
          get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions")
        end

        def post_suppressed_emails(group_id, recipient_emails)
          resp = post(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions",
            {"recipient_emails" => recipient_emails})
          resp["recipient_emails"]
        end

        def delete_suppressed_email(group_id, email_address)
          delete(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions/#{email_address}")
        end

      end
    end
  end
end
