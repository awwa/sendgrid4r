# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rest-client'
require 'uri'
require 'json'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Request
    #
    module Request
      def get(auth, endpoint, params = nil)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        p = { params: params } unless params.nil?
        if p.nil?
          body = resource.get
        else
          body = resource.get(p)
          # TODO: handle ratelimit headers
          # do |response, request, result, &block|
          #   # puts response.headers
          #   break response.body
          # end
        end
        JSON.parse(body)
      end

      def post(auth, endpoint, params = nil)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        if params.nil?
          body = resource.post(content_type: :json).body
        else
          body = resource.post(params.to_json, content_type: :json).body
        end
        JSON.parse(body) if body.length > 1
      end

      def patch(auth, endpoint, params)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        body = resource.patch(params.to_json, content_type: :json).body
        JSON.parse(body)
      end

      def put(auth, endpoint, params)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        body = resource.put(params.to_json, content_type: :json).body
        JSON.parse(body)
      end

      def delete(auth, endpoint, params = nil)
        # We need to add payload for delete method.
        args = {}
        args[:method] = :delete
        args[:url] = endpoint
        args[:user] = auth.username
        args[:password] = auth.password
        args[:headers] = {content_type: :json}
        args[:payload] = params.to_json unless params.nil?
        request = RestClient::Request.new(args)
        request.execute()
      end
    end
  end
end
