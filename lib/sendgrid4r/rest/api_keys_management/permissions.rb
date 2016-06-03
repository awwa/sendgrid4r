# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 ApiKeysManagement
  #
  module ApiKeysManagement
    #
    # SendGrid Web API v3 ApiKeysManagement Permissions
    #
    module Permissions
      include Request

      Permissions = Struct.new(:scopes)

      def self.url
        "#{BASE_URL}/scopes"
      end

      def self.create_permissions(resp)
        return resp if resp.nil?
        Permissions.new(resp['scopes'])
      end

      def get_permissions(&block)
        resp = get(@auth, ApiKeysManagement::Permissions.url, &block)
        ApiKeysManagement::Permissions.create_permissions(resp)
      end
    end
  end
end
