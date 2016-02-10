# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/auth'
require 'sendgrid4r/rest/api'
require 'sendgrid4r/factory/version_factory'
require 'sendgrid4r/factory/condition_factory'
require 'sendgrid4r/factory/segment_factory'
require 'sendgrid4r/factory/campaign_factory'

module SendGrid4r
  #
  # SendGrid Web API v3 Client implementation
  #
  class Client
    include SendGrid4r::REST::API

    def initialize(
      username: nil, password: nil, api_key: nil
    )
      @auth = Auth.new(username: username, password: password, api_key: api_key)
    end
  end
end
