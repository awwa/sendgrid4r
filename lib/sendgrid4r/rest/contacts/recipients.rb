# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Recipients
      #
      module Recipients
        include SendGrid4r::REST::Request

        Recipient = Struct.new(
          :created_at,
          :custom_fields,
          :email,
          :first_name,
          :id,
          :last_clicked,
          :last_emailed,
          :last_name,
          :last_opened,
          :updated_at
        )

        Recipients = Struct.new(:recipients)

        def self.create_recipient(resp)
          return resp if resp.nil?
          custom_fields = []
          unless resp['custom_fields'].nil?
            resp['custom_fields'].each do |field|
              custom_fields.push(
                SendGrid4r::REST::Contacts::CustomFields.create_field(field)
              )
            end
          end
          Recipient.new(
            Time.at(resp['created_at']), custom_fields,
            resp['email'], resp['first_name'], resp['id'],
            resp['last_clicked'], resp['last_emailed'],
            resp['last_name'], resp['last_opened'],
            Time.at(resp['updated_at'])
          )
        end

        def self.create_recipients(resp)
          return resp if resp.nil?
          recipients = []
          resp['recipients'].each do |recipient|
            recipients.push(
              SendGrid4r::REST::Contacts::Recipients.create_recipient(recipient)
            )
          end
          Recipients.new(recipients)
        end

        def self.url(recipient_id = nil)
          url = "#{BASE_URL}/contactdb/recipients"
          url = "#{url}/#{recipient_id}" unless recipient_id.nil?
          url
        end

        def post_recipients(params:, &block)
          endpoint = SendGrid4r::REST::Contacts::Recipients.url
          resp = post(@auth, endpoint, params, &block)
          SendGrid4r::REST::Contacts::Recipients.create_result(resp)
        end

        def patch_recipients(params:, &block)
          endpoint = SendGrid4r::REST::Contacts::Recipients.url
          resp = patch(@auth, endpoint, params, &block)
          SendGrid4r::REST::Contacts::Recipients.create_result(resp)
        end

        def delete_recipients(recipient_ids:, &block)
          endpoint = SendGrid4r::REST::Contacts::Recipients.url
          delete(@auth, endpoint, nil, recipient_ids, &block)
        end

        def get_recipients(page: nil, page_size: nil, &block)
          params = {}
          params['page_size'] = page_size unless page_size.nil?
          params['page'] = page unless page.nil?
          endpoint = SendGrid4r::REST::Contacts::Recipients.url
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end

        def get_recipient(recipient_id:, &block)
          endpoint = SendGrid4r::REST::Contacts::Recipients.url(recipient_id)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Contacts::Recipients.create_recipient(resp)
        end

        def delete_recipient(recipient_id:, &block)
          endpoint = SendGrid4r::REST::Contacts::Recipients.url(recipient_id)
          delete(@auth, endpoint, &block)
        end

        def get_lists_recipient_belong(recipient_id:, &block)
          resp = get(
            @auth,
            "#{SendGrid4r::REST::Contacts::Recipients.url(recipient_id)}/lists",
            &block
          )
          SendGrid4r::REST::Contacts::Lists.create_lists(resp)
        end

        def get_recipients_count(&block)
          endpoint = "#{SendGrid4r::REST::Contacts::Recipients.url}/count"
          resp = get(@auth, endpoint, &block)
          resp['recipient_count'] unless resp.nil?
        end

        def search_recipients(params:, &block)
          endpoint = "#{SendGrid4r::REST::Contacts::Recipients.url}/search"
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end

        Result = Struct.new(
          :error_count,
          :error_indices,
          :new_count,
          :persisted_recipients,
          :updated_count
        )

        def self.create_result(resp)
          return resp if resp.nil?
          error_indices = []
          resp['error_indices'].each do |index|
            error_indices.push(index)
          end
          persisted_recipients = []
          resp['persisted_recipients'].each do |value|
            persisted_recipients.push(value)
          end
          Result.new(
            resp['error_count'],
            error_indices,
            resp['new_count'],
            persisted_recipients,
            resp['updated_count']
          )
        end
      end
    end
  end
end
