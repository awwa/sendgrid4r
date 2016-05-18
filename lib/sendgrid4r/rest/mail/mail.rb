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

    def self.warn_beta
      warn(
        '[WARN] Mail endpoint is currently in beta! We do not recommend '\
        'use this method in production. When this endpoint is ready for '\
        'general release, your code will require an update in order to '\
        'use the official one.'
      )
    end

    def send(params:, &block)
      Mail.warn_beta
      post(@auth, Mail.url, params.to_h, &block)
    end
  end
end
