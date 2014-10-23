# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Asm
      module Suppressions

        include SendGrid4r::REST::Request

        def get_suppressions(email_address)
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/#{email_address}")
          suppressions = Array.new
          response["suppressions"].each{|spr|
            suppression = Suppression.create(spr)
            suppressions.push(suppression)
          } if response["suppressions"] != nil
          suppressions
        end

        def get_suppressed_emails(group_id)
          get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions")
        end

        def post_suppressed_emails(group_id, recipient_emails)
          params = Hash.new
          params["recipient_emails"] = recipient_emails
          response = post(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions", params.to_hash)
          recipient_emails = response["recipient_emails"]
          recipient_emails
        end

        def delete_suppressed_email(group_id, email_address)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}/suppressions/#{email_address}")
        end

      end

      class Suppression

        attr_accessor :id, :name, :description, :suppressed

        def self.create(value)
          obj = Suppression.new
          obj.id = value["id"]
          obj.name = value["name"]
          obj.description = value["description"]
          obj.suppressed = value["suppressed"]
          obj
        end

      end
    end
  end
end
