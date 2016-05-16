# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    include Request

    def self.url
      "#{BASE_URL}/mail/send/beta"
    end

    def send(params: params, &block)
      post(@auth, Mail.url, params.to_h, &block)
    end
  end
end
