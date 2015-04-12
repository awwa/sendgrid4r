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
        Suppressions = Struct.new(:suppressions)

        def self.url(group_id, email_address = nil)
          url =
            "#{SendGrid4r::Client::BASE_URL}"\
            "/asm/groups/#{group_id}/suppressions"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def self.create_suppressions(resp)
          resp if resp.nil?
          suppressions = []
          resp['suppressions'].each do |suppression|
            suppressions.push(
              SendGrid4r::REST::Asm::Suppressions.create_suppression(
                suppression
              )
            )
          end
          Suppressions.new(suppressions)
        end

        def self.create_suppression(resp)
          resp if resp.nil?
          Suppression.new(
            resp['id'], resp['name'], resp['description'], resp['suppressed']
          )
        end

        def post_suppressed_emails(group_id, recipient_emails)
          resp = post(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id),
            recipient_emails: recipient_emails
          )
          SendGrid4r::REST::Asm.create_recipient_emails(resp)
        end

        def get_suppressed_emails(group_id)
          get(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id)
          )
        end

        def get_suppressions(email_address)
          resp = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/asm/suppressions/#{email_address}")
          SendGrid4r::REST::Asm::Suppressions.create_suppressions(resp)
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
