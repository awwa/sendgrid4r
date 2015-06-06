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
          url = "#{BASE_URL}/asm/groups/#{group_id}/suppressions"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def self.create_suppressions(resp)
          return resp if resp.nil?
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
          return resp if resp.nil?
          Suppression.new(
            resp['id'], resp['name'], resp['description'], resp['suppressed']
          )
        end

        def self.create_emails(resp)
          return resp if resp.nil?
          emails = []
          resp.each do |email|
            emails.push(email)
          end
          emails
        end

        def post_suppressed_emails(group_id:, recipient_emails:, &block)
          resp = post(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id),
            recipient_emails: recipient_emails,
            &block
          )
          SendGrid4r::REST::Asm.create_recipient_emails(resp)
        end

        def get_suppressed_emails(group_id:, &block)
          endpoint = SendGrid4r::REST::Asm::Suppressions.url(group_id)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Asm::Suppressions.create_emails(resp)
        end

        def get_suppressions(email_address:, &block)
          endpoint = "#{BASE_URL}/asm/suppressions/#{email_address}"
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Asm::Suppressions.create_suppressions(resp)
        end

        def delete_suppressed_email(group_id:, email_address:, &block)
          delete(
            @auth,
            SendGrid4r::REST::Asm::Suppressions.url(group_id, email_address),
            &block
          )
        end
      end
    end
  end
end
