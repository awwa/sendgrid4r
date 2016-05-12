# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module MarketingCampaigns
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Lists
      #
      module Lists
        include Request

        List = Struct.new(:id, :name, :recipient_count)
        Lists = Struct.new(:lists)

        def self.url(list_id = nil)
          url = "#{BASE_URL}/contactdb/lists"
          url = "#{url}/#{list_id}" unless list_id.nil?
          url
        end

        def self.recipients_url(list_id, recipient_id = nil)
          url = "#{Contacts::Lists.url(list_id)}/recipients"
          url = "#{url}/#{recipient_id}" unless recipient_id.nil?
          url
        end

        def self.create_list(resp)
          return resp if resp.nil?
          List.new(resp['id'], resp['name'], resp['recipient_count'])
        end

        def self.create_lists(resp)
          return resp if resp.nil?
          lists = resp['lists'].map { |list| Contacts::Lists.create_list(list) }
          Lists.new(lists)
        end

        def post_list(name:, &block)
          params = {}
          params['name'] = name
          resp = post(@auth, Contacts::Lists.url, params, &block)
          Contacts::Lists.create_list(resp)
        end

        def get_lists(&block)
          resp = get(@auth, Contacts::Lists.url, &block)
          Contacts::Lists.create_lists(resp)
        end

        def get_list(list_id:, &block)
          resp = get(@auth, Contacts::Lists.url(list_id), &block)
          Contacts::Lists.create_list(resp)
        end

        def patch_list(list_id:, name:, &block)
          params = {}
          params['name'] = name
          resp = patch(@auth, Contacts::Lists.url(list_id), params, &block)
          Contacts::Lists.create_list(resp)
        end

        def delete_list(list_id:, &block)
          delete(@auth, Contacts::Lists.url(list_id), &block)
        end

        # no bodies returned
        def post_recipients_to_list(list_id:, recipients:, &block)
          endpoint = "#{Contacts::Lists.url(list_id)}/recipients"
          post(@auth, endpoint, recipients, &block)
        end

        def get_recipients_from_list(list_id:, page: nil, page_size: nil, &block)
          params = {}
          params['page'] = page unless page.nil?
          params['page_size'] = page_size unless page_size.nil?
          endpoint = Contacts::Lists.recipients_url(list_id)
          resp = get(@auth, endpoint, params, &block)
          Contacts::Recipients.create_recipients(resp)
        end

        def post_recipient_to_list(list_id:, recipient_id:, &block)
          endpoint = Contacts::Lists.recipients_url(list_id, recipient_id)
          post(@auth, endpoint, &block)
        end

        def delete_recipient_from_list(list_id:, recipient_id:, &block)
          endpoint = Contacts::Lists.recipients_url(list_id, recipient_id)
          delete(@auth, endpoint, &block)
        end

        def delete_lists(list_ids:, &block)
          delete(@auth, "#{BASE_URL}/contactdb/lists", nil, list_ids, &block)
        end
      end
    end
  end
end
