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
      def get(auth, endpoint, params = nil, payload = nil, &block)
        execute(:get, auth, endpoint, params, payload, &block)
      end

      def post(auth, endpoint, payload = nil, &block)
        execute(:post, auth, endpoint, nil, payload, &block)
      end

      def patch(auth, endpoint, payload, &block)
        execute(:patch, auth, endpoint, nil, payload, &block)
      end

      def put(auth, endpoint, payload, &block)
        execute(:put, auth, endpoint, nil, payload, &block)
      end

      def delete(auth, endpoint, payload = nil, &block)
        execute(:delete, auth, endpoint, nil, payload, &block)
      end

      def execute(method, auth, endpoint, params, payload, &block)
        args = create_args(method, auth, endpoint, params, payload)
        if block_given?
          RestClient::Request.execute(args, &block)
          return nil
        end
        body = RestClient::Request.execute(args)
        if body.nil? || body.length < 2
          body
        else
          JSON.parse(body)
        end
      end

      def create_args(method, auth, endpoint, params, payload)
        args = {}
        args[:method] = method
        args[:url] = process_url_params(endpoint, params)
        headers = {}
        headers[:content_type] = :json
        if !auth.api_key.nil?
          headers[:authorization] = "Bearer #{auth.api_key}"
        else
          args[:user] = auth.username
          args[:password] = auth.password
        end
        args[:headers] = headers
        args[:payload] = payload.to_json unless payload.nil?
        args
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
