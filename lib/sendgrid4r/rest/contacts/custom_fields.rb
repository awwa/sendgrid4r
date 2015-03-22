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
        # TODO: add key for eql? and hash
        Field = Struct.new(:id, :name, :type, :value)
        Fields = Struct.new(:custom_fields)

        def self.url(custom_field_id = nil)
          url = "#{SendGrid4r::Client::BASE_URL}/contactdb/custom_fields"
          url = "#{url}/#{custom_field_id}" unless custom_field_id.nil?
          url
        end

        def self.create_fields(resp)
          custom_fields = []
          resp['custom_fields'].each do |field|
            custom_fields.push(
              SendGrid4r::REST::Contacts::CustomFields.create_field(field)
            )
          end
          Fields.new(custom_fields)
        end

        def self.create_field(resp)
          Field.new(resp['id'], resp['name'], resp['type'], resp['value'])
        end

        def post_custom_field(name, type)
          params = {}
          params['name'] = name
          params['type'] = type
          resp = post(
            @auth, SendGrid4r::REST::Contacts::CustomFields.url, params
          )
          SendGrid4r::REST::Contacts::CustomFields.create_field(resp)
        end

        def get_custom_fields
          resp = get(@auth, SendGrid4r::REST::Contacts::CustomFields.url)
          SendGrid4r::REST::Contacts::CustomFields.create_fields(resp)
        end

        def get_custom_field(custom_field_id)
          resp = get(
            @auth,
            SendGrid4r::REST::Contacts::CustomFields.url(custom_field_id)
          )
          SendGrid4r::REST::Contacts::CustomFields.create_field(resp)
        end

        def delete_custom_field(custom_field_id)
          delete(
            @auth,
            SendGrid4r::REST::Contacts::CustomFields.url(custom_field_id)
          )
        end
      end
    end
  end
end
