# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Custom Fields
      #
      module CustomFields
        include SendGrid4r::REST::Request

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
          url = "#{SendGrid4r::Client::BASE_URL}/contactdb/custom_fields"
          url = "#{url}/#{custom_field_id}" unless custom_field_id.nil?
          url
        end

        def self.create_field(resp)
          return resp if resp.nil?
          Field.new(resp['id'], resp['name'], resp['type'], resp['value'])
        end

        def self.create_fields(resp)
          return resp if resp.nil?
          custom_fields = []
          resp['custom_fields'].each do |field|
            custom_fields.push(
              SendGrid4r::REST::Contacts::CustomFields.create_field(field)
            )
          end
          Fields.new(custom_fields)
        end

        def post_custom_field(name, type, &block)
          params = {}
          params['name'] = name
          params['type'] = type
          resp = post(
            @auth, SendGrid4r::REST::Contacts::CustomFields.url, params, &block
          )
          SendGrid4r::REST::Contacts::CustomFields.create_field(resp)
        end

        def get_custom_fields(&block)
          resp = get(
            @auth, SendGrid4r::REST::Contacts::CustomFields.url, &block
          )
          SendGrid4r::REST::Contacts::CustomFields.create_fields(resp)
        end

        def get_custom_field(custom_field_id, &block)
          resp = get(
            @auth,
            SendGrid4r::REST::Contacts::CustomFields.url(custom_field_id),
            &block
          )
          SendGrid4r::REST::Contacts::CustomFields.create_field(resp)
        end

        def delete_custom_field(custom_field_id, &block)
          delete(
            @auth,
            SendGrid4r::REST::Contacts::CustomFields.url(custom_field_id),
            &block
          )
        end
      end
    end
  end
end
