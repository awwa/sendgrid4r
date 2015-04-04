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
      # TODO: handle ratelimit headers
      def get(auth, endpoint, params = nil, payload = nil)
        args = {}
        args[:method] = :get
        args[:url] = process_url_params(endpoint, params)
        args[:user] = auth.username
        args[:password] = auth.password
        args[:headers] = { content_type: :json }
        args[:payload] = payload.to_json unless payload.nil?
        JSON.parse(RestClient::Request.execute(args))
      end

      def post(auth, endpoint, payload = nil)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        if payload.nil?
          body = resource.post(content_type: :json).body
        else
          body = resource.post(payload.to_json, content_type: :json).body
        end
        JSON.parse(body) if body.length > 1
      end

      def patch(auth, endpoint, payload)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        body = resource.patch(payload.to_json, content_type: :json).body
        JSON.parse(body)
      end

      def put(auth, endpoint, payload)
        resource = RestClient::Resource.new(
          endpoint, auth.username, auth.password)
        body = resource.put(payload.to_json, content_type: :json).body
        JSON.parse(body)
      end

      def delete(auth, endpoint, payload = nil)
        # We need to add payload for delete method.
        args = {}
        args[:method] = :delete
        args[:url] = endpoint
        args[:user] = auth.username
        args[:password] = auth.password
        args[:headers] = { content_type: :json }
        args[:payload] = payload.to_json unless payload.nil?
        RestClient::Request.execute(args)
      end

      def process_url_params(endpoint, params)
        if params.nil? || params.empty?
          endpoint
        else
          query_string = params.collect do |k, v|
            "#{k}=#{CGI.escape(v.to_s)}"
          end.join('&')
          endpoint + "?#{query_string}"
        end
      end
    end
  end
end
