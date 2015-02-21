# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Asm
      #
      # SendGrid Web API v3 Advanced Suppression Manager - Suppressions
      #
      module Suppressions
        include SendGrid4r::REST::Request

        Suppression = Struct.new(:id, :name, :description, :suppressed)

        def self.url(group_id, email_address = nil)
          url =
            "#{SendGrid4r::Client::BASE_URL}"\
            "/asm/groups/#{group_id}/suppressions"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def self.create_suppression(resp)
          Suppression.new(
            resp['id'], resp['name'], resp['description'], resp['suppressed'])
        end

        def get_suppressions(email_address)
          resp_a = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/#{email_address}")
          suppressions = []
          resp_a['suppressions'].each do |resp|
            suppressions.push(
              SendGrid4r::REST::Asm::Suppressions.create_suppression(resp)
            )
          end
          suppressions
        end

        def get_suppressed_emails(group_id)
          get(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id)
          )
        end

        def post_suppressed_emails(group_id, recipient_emails)
          resp = post(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id),
            recipient_emails: recipient_emails
          )
          resp['recipient_emails']
        end

        def delete_suppressed_email(group_id, email_address)
          delete(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id, email_address)
          )
        end
      end
    end
  end
end
