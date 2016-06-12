# -*- encoding: utf-8 -*-

require 'rest-client'
require 'uri'
require 'json'

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Request
  #
  module Request
    BASE_URL = 'https://api.sendgrid.com/v3'

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

    def delete(auth, endpoint, params = nil, payload = nil, &block)
      execute(:delete, auth, endpoint, params, payload, &block)
    end

    def execute(method, auth, endpoint, params, payload, &block)
      args = create_args(method, auth, endpoint, params, payload)
      RestClient::Request.execute(args, &block)
    rescue RestClient::TooManyRequests => e
      duration = e.response.headers[:x_ratelimit_remaining].to_i
      sleep duration if duration > 0
      retry
    end

    def create_args(method, auth, endpoint, params, payload)
      args = {}
      args[:method] = method
      args[:url] = process_url_params(endpoint, params)
      headers = {}
      headers[:content_type] = :json
      # Added for Campaign API
      headers['Accept-Encoding'] = 'plain'
      #
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
          "#{k}=#{CGI.escape(process_array_params(v))}"
        end.join('&')
        endpoint + "?#{query_string}"
      end
    end

    def process_array_params(v)
      v.is_a?(Array) ? v.join(',') : v.to_s
    end

    def finish(resp, raw_resp = false)
      return resp if raw_resp || resp.nil? || resp.length < 2
      yield(JSON.parse(resp))
    end
  end
end
