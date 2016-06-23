# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module MarketingCampaigns
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Custom Fields
      #
      module CustomFields
        include Request

        Field = Struct.new(:id, :name, :type, :value) do
          def eql?(other)
            id.eql?(other.id)
          end

          def hash
            id.hash
          end
        end

        Fields = Struct.new(:custom_fields)

        def self.url(custom_field_id = nil)
          url = "#{BASE_URL}/contactdb/custom_fields"
          url = "#{url}/#{custom_field_id}" unless custom_field_id.nil?
          url
        end

        def self.create_field(resp)
          return resp if resp.nil?
          Field.new(resp['id'], resp['name'], resp['type'], resp['value'])
        end

        def self.create_fields(resp)
          return resp if resp.nil?
          custom_fields = resp['custom_fields'].map do |field|
            Contacts::CustomFields.create_field(field)
          end
          Fields.new(custom_fields)
        end

        def post_custom_field(name:, type:, &block)
          params = {}
          params['name'] = name
          params['type'] = type
          resp = post(@auth, Contacts::CustomFields.url, params, &block)
          finish(resp, @raw_resp) do |r|
            Contacts::CustomFields.create_field(r)
          end
        end

        def get_custom_fields(&block)
          resp = get(@auth, Contacts::CustomFields.url, &block)
          finish(resp, @raw_resp) do |r|
            Contacts::CustomFields.create_fields(r)
          end
        end

        def get_custom_field(custom_field_id:, &block)
          resp = get(@auth, Contacts::CustomFields.url(custom_field_id), &block)
          finish(resp, @raw_resp) do |r|
            Contacts::CustomFields.create_field(r)
          end
        end

        def delete_custom_field(custom_field_id:, &block)
          delete(@auth, Contacts::CustomFields.url(custom_field_id), &block)
        end
      end
    end
  end
end
