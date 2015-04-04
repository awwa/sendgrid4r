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
        execute(:get, auth, endpoint, params, payload)
      end

      def post(auth, endpoint, payload = nil)
        execute(:post, auth, endpoint, nil, payload)
      end

      def patch(auth, endpoint, payload)
        execute(:patch, auth, endpoint, nil, payload)
      end

      def put(auth, endpoint, payload)
        execute(:put, auth, endpoint, nil, payload)
      end

      def delete(auth, endpoint, payload = nil)
        execute(:delete, auth, endpoint, nil, payload)
      end

      def execute(method, auth, endpoint, params, payload)
        args = {}
        args[:method] = method
        args[:url] = process_url_params(endpoint, params)
        args[:user] = auth.username
        args[:password] = auth.password
        args[:headers] = { content_type: :json }
        args[:payload] = payload.to_json unless payload.nil?
        body = RestClient::Request.execute(args)
        if body.nil? || body.length < 2
          body
        else
          JSON.parse(body)
        end
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
