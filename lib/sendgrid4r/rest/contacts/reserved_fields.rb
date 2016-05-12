# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Contacts
    #
    # SendGrid Web API v3 Contacts - Reserved Fields
    #
    module ReservedFields
      include Request

      Field = Struct.new(:name, :type) do
        def eql?(other)
          name.eql?(other.name)
        end

        def hash
          name.hash
        end
      end

      Fields = Struct.new(:reserved_fields)

      def self.create_fields(resp)
        return resp if resp.nil?
        reserved_fields = resp['reserved_fields'].map do |field|
          Contacts::ReservedFields.create_field(field)
        end
        Fields.new(reserved_fields)
      end

      def self.create_field(resp)
        return resp if resp.nil?
        Field.new(resp['name'], resp['type'])
      end

      def get_reserved_fields(&block)
        resp = get(@auth, "#{BASE_URL}/contactdb/reserved_fields", &block)
        Contacts::ReservedFields.create_fields(resp)
      end
    end
  end
end
