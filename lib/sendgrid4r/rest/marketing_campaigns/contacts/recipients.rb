# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module MarketingCampaigns
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Recipients
      #
      module Recipients
        include Request

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

        Count = Struct.new(:recipient_count)

        def self.create_recipient(resp)
          return resp if resp.nil?
          custom_fields = []
          custom_fields = resp['custom_fields'].map do |field|
            Contacts::CustomFields.create_field(field)
          end unless resp['custom_fields'].nil?
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
          recipients = resp['recipients'].map do |recipient|
            Contacts::Recipients.create_recipient(recipient)
          end
          Recipients.new(recipients)
        end

        def self.create_recipient_count(resp)
          return resp if resp.nil?
          Count.new(resp['recipient_count'])
        end

        def self.url(recipient_id = nil)
          url = "#{BASE_URL}/contactdb/recipients"
          url = "#{url}/#{recipient_id}" unless recipient_id.nil?
          url
        end

        def post_recipients(params:, &block)
          resp = post(@auth, Contacts::Recipients.url, params, &block)
          finish(resp, @raw_resp) { |r| Contacts::Recipients.create_result(r) }
        end

        def patch_recipients(params:, &block)
          resp = patch(@auth, Contacts::Recipients.url, params, &block)
          finish(resp, @raw_resp) { |r| Contacts::Recipients.create_result(r) }
        end

        def delete_recipients(recipient_ids:, &block)
          delete(@auth, Contacts::Recipients.url, nil, recipient_ids, &block)
        end

        def get_recipients(page: nil, page_size: nil, &block)
          params = {}
          params['page_size'] = page_size unless page_size.nil?
          params['page'] = page unless page.nil?
          resp = get(@auth, Contacts::Recipients.url, params, &block)
          finish(resp, @raw_resp) do |r|
            Contacts::Recipients.create_recipients(r)
          end
        end

        def get_recipient(recipient_id:, &block)
          resp = get(@auth, Contacts::Recipients.url(recipient_id), &block)
          finish(resp, @raw_resp) do |r|
            Contacts::Recipients.create_recipient(r)
          end
        end

        def delete_recipient(recipient_id:, &block)
          delete(@auth, Contacts::Recipients.url(recipient_id), &block)
        end

        def get_lists_recipient_belong(recipient_id:, &block)
          resp = get(
            @auth, "#{Contacts::Recipients.url(recipient_id)}/lists", &block
          )
          finish(resp, @raw_resp) { |r| Contacts::Lists.create_lists(r) }
        end

        def get_recipients_count(&block)
          resp = get(@auth, "#{Contacts::Recipients.url}/count", &block)
          finish(resp, @raw_resp) do |r|
            Contacts::Recipients.create_recipient_count(r)
          end.recipient_count
        end

        def search_recipients(params:, &block)
          endpoint = "#{Contacts::Recipients.url}/search"
          resp = get(@auth, endpoint, params, &block)
          finish(resp, @raw_resp) do |r|
            Contacts::Recipients.create_recipients(r)
          end
        end

        Result = Struct.new(
          :error_count,
          :error_indices,
          :new_count,
          :persisted_recipients,
          :updated_count,
          :errors
        )

        def self.create_result(resp)
          return resp if resp.nil?
          errors = resp['errors'].map do |error|
            Contacts::Recipients.create_error(error)
          end unless resp['errors'].nil?
          Result.new(
            resp['error_count'], resp['error_indices'], resp['new_count'],
            resp['persisted_recipients'], resp['updated_count'], errors
          )
        end

        Error = Struct.new(:error_indices, :message)

        def self.create_error(resp)
          return resp if resp.nil?
          Error.new(resp['error_indices'], resp['message'])
        end
      end
    end
  end
end
