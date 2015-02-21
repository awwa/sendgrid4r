# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'auth'
require 'sendgrid4r/rest/api'
require 'sendgrid4r/factory/version_factory'

module SendGrid4r
  #
  # SendGrid Web API v3 Client implementation
  #
  class Client
    include SendGrid4r::REST::API

    BASE_URL = 'https://api.sendgrid.com/v3'

    def initialize(username, password)
      @auth = Auth.new(username, password)
    end
  end
end
