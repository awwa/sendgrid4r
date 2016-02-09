# -*- encoding: utf-8 -*-


module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Webhooks
    #
    module Webhooks
      #
      # SendGrid Web API v3 Webhooks ParseApi
      #
      module ParseApi
        include SendGrid4r::REST::Request

        ParseSettings = Struct.new(:url, :hostname, :spam_check_outgoing)

        def self.url
          "#{BASE_URL}/webhooks/parse/settings"
        end

        def self.create_parse_settings(resp)
          return resp if resp.nil?
          ParseSettings.new(
            resp['url'],
            resp['hostname'],
            resp['spam_check_outgoing']
          )
        end

        def get_parse_settings(&block)
          resp = get(@auth, SendGrid4r::REST::Webhooks::ParseApi.url, &block)
          SendGrid4r::REST::Webhooks::ParseApi.create_parse_settings(resp)
        end
      end
    end
  end
end
