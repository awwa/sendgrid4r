# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Reserved Fields
      #
      module ReservedFields
        include SendGrid4r::REST::Request

        Fields = Struct.new(:reserved_fields)
        Field = Struct.new(:name, :type) do
          def eql?(other)
            name.eql?(other.name)
          end

          def hash
            name.hash
          end
        end

        def self.create_fields(resp)
          reserved_fields = []
          resp['reserved_fields'].each do |field|
            reserved_fields.push(
              SendGrid4r::REST::Contacts::ReservedFields.create_field(field)
            )
          end
          Fields.new(reserved_fields)
        end

        def self.create_field(resp)
          Field.new(resp['name'], resp['type'])
        end

        def get_reserved_fields
          resp = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/contactdb/reserved_fields"
          )
          SendGrid4r::REST::Contacts::ReservedFields.create_fields(resp)
        end
      end
    end
  end
end
