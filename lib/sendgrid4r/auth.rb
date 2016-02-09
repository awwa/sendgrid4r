# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

module SendGrid4r
  #
  # SendGrid Web API v3 data container for authentication
  #
  class Auth
    attr_reader :username, :password, :api_key

    def initialize(
      username: nil, password: nil, api_key: nil
    )
      @username = username
      @password = password
      @api_key = api_key
    end
  end
end
