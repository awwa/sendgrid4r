# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 ApiKeys
    #
    module ApiKeys
      include SendGrid4r::REST::Request

      ApiKeys = Struct.new(:result)
      ApiKey = Struct.new(:name, :api_key_id, :api_key, :scope_set_id)

      def self.url(api_key = nil)
        url = "#{BASE_URL}/api_keys"
        url = "#{url}/#{api_key}" unless api_key.nil?
        url
      end

      def self.create_api_keys(resp)
        return resp if resp.nil?
        api_keys = []
        resp['result'].each do |api_key|
          api_keys.push(SendGrid4r::REST::ApiKeys.create_api_key(api_key))
        end
        ApiKeys.new(api_keys)
      end

      def self.create_api_key(resp)
        return resp if resp.nil?
        ApiKey.new(
          resp['name'],
          resp['api_key_id'],
          resp['api_key'],
          resp['scope_set_id']
        )
      end

      def get_api_keys(&block)
        resp = get(@auth, SendGrid4r::REST::ApiKeys.url, &block)
        SendGrid4r::REST::ApiKeys.create_api_keys(resp)
      end

      def post_api_key(name, &block)
        params = {}
        params['name'] = name
        resp = post(@auth, SendGrid4r::REST::ApiKeys.url, params, &block)
        SendGrid4r::REST::ApiKeys.create_api_key(resp)
      end

      def delete_api_key(api_key, &block)
        delete(@auth, SendGrid4r::REST::ApiKeys.url(api_key), &block)
      end

      def patch_api_key(api_key, name, &block)
        params = {}
        params['name'] = name
        endpoint = SendGrid4r::REST::ApiKeys.url(api_key)
        resp = patch(@auth, endpoint, params, &block)
        SendGrid4r::REST::ApiKeys.create_api_key(resp)
      end
    end
  end
end
