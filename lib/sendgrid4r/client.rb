# -*- encoding: utf-8 -*-

module SendGrid4r
  #
  # SendGrid Web API v3 Client implementation
  #
  class Client
    include SendGrid4r::REST::API

    def initialize(
      username: nil, password: nil, api_key: nil, raw_response: false
    )
      @auth = Auth.new(username: username, password: password, api_key: api_key)
      @raw_resp = raw_response
    end
  end
end
