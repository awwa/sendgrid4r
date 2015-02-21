# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

module SendGrid4r
  #
  # SendGrid Web API v3 data container for authentication
  #
  class Auth
    attr_reader :username, :password

    def initialize(username, password)
      @username = username
      @password = password
    end
  end
end
