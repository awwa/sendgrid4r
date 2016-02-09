# -*- encoding: utf-8 -*-

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 ApiKeys
    #
    module ApiKeys
      #
      # SendGrid Web API v3 ApiKeys Permissions
      #
      module Permissions
        include SendGrid4r::REST::Request

        Permissions = Struct.new(:scopes)

        def self.url
          "#{BASE_URL}/scopes"
        end

        def self.create_permissions(resp)
          return resp if resp.nil?
          Permissions.new(resp['scopes'])
        end

        def get_permissions(&block)
          resp = get(@auth, SendGrid4r::REST::ApiKeys::Permissions.url, &block)
          SendGrid4r::REST::ApiKeys::Permissions.create_permissions(resp)
        end
      end
    end
  end
end
