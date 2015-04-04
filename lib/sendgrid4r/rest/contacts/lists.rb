# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Lists
      #
      module Lists
        include SendGrid4r::REST::Request

        List = Struct.new(:id, :name, :recipient_count)
        Lists = Struct.new(:lists)

        def self.url(list_id = nil)
          url = "#{SendGrid4r::Client::BASE_URL}/contactdb/lists"
          url = "#{url}/#{list_id}" unless list_id.nil?
          url
        end

        def self.recipients_url(list_id, recipient_id = nil)
          url = "#{SendGrid4r::REST::Contacts::Lists.url(list_id)}/recipients"
          url = "#{url}/#{recipient_id}" unless recipient_id.nil?
          url
        end

        def self.create_list(resp)
          List.new(resp['id'], resp['name'], resp['recipient_count'])
        end

        def self.create_lists(resp)
          lists = []
          resp['lists'].each do |list|
            lists.push(SendGrid4r::REST::Contacts::Lists.create_list(list))
          end
          Lists.new(lists)
        end

        def post_list(name)
          params = {}
          params['name'] = name
          resp = post(@auth, SendGrid4r::REST::Contacts::Lists.url, params)
          SendGrid4r::REST::Contacts::Lists.create_list(resp)
        end

        def get_lists
          resp = get(@auth, SendGrid4r::REST::Contacts::Lists.url)
          SendGrid4r::REST::Contacts::Lists.create_lists(resp)
        end

        def get_list(list_id)
          resp = get(@auth, SendGrid4r::REST::Contacts::Lists.url(list_id))
          SendGrid4r::REST::Contacts::Lists.create_list(resp)
        end

        def patch_list(list_id, name)
          params = {}
          params['name'] = name
          resp = patch(
            @auth,
            SendGrid4r::REST::Contacts::Lists.url(list_id),
            params
          )
          SendGrid4r::REST::Contacts::Lists.create_list(resp)
        end

        def delete_list(list_id)
          delete(@auth, SendGrid4r::REST::Contacts::Lists.url(list_id))
        end

        # no bodies returned
        def post_recipients_to_list(list_id, recipients)
          url = SendGrid4r::REST::Contacts::Lists.url(list_id)
          post(
            @auth,
            "#{url}/recipients_batch",
            recipients
          )
        end

        def get_recipients_from_list(list_id, limit = nil, offset = nil)
          params = {}
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless offset.nil?
          resp = get(
            @auth,
            SendGrid4r::REST::Contacts::Lists.recipients_url(list_id),
            params
          )
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end

        def post_recipient_to_list(list_id, recipient_id)
          post(
            @auth,
            SendGrid4r::REST::Contacts::Lists.recipients_url(
              list_id, recipient_id
            )
          )
        end

        def delete_recipient_from_list(list_id, recipient_id)
          delete(
            @auth,
            SendGrid4r::REST::Contacts::Lists.recipients_url(
              list_id, recipient_id
            )
          )
        end

        # TODO: rest-client does not support the body for delete method
        def delete_lists(list_ids)
          delete(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/contactdb/lists_batch",
            list_ids
          )
        end
      end
    end
  end
end
