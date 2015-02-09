# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "rest-client"
require "uri"
require "json"

module SendGrid4r
  module REST
    module Request

      def get(auth, endpoint, params = nil)
        resource = RestClient::Resource.new(endpoint, auth.get_username, auth.get_password)
        p = {"params" => params} if !params.nil?
        body = resource.get(p)
        JSON.parse(body)
      end

      def post(auth, endpoint, params = nil)
        resource = RestClient::Resource.new(endpoint, auth.get_username, auth.get_password)
        if params == nil
          body = resource.post(:content_type => :json).body
        else
          body = resource.post(params.to_json, :content_type => :json).body
        end
        JSON.parse(body)
      end

      def patch(auth, endpoint, params)
        resource = RestClient::Resource.new(endpoint, auth.get_username, auth.get_password)
        body = resource.patch(params.to_json, :content_type => :json).body
        JSON.parse(body)
      end

      def put(auth, endpoint, params)
        resource = RestClient::Resource.new(endpoint, auth.get_username, auth.get_password)
        body = resource.put(params.to_json, :content_type => :json).body
        JSON.parse(body)
      end

      def delete(auth, endpoint)
        resource = RestClient::Resource.new(endpoint, auth.get_username, auth.get_password)
        resource.delete
      end

    end

  end
end
