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

        ParseSettings = Struct.new(:result)
        ParseSetting = Struct.new(:url, :hostname, :spam_check_outgoing)

        def self.url
          "#{BASE_URL}/user/webhooks/parse/settings"
        end

        def self.create_parse_settings(resp)
          return resp if resp.nil?
          parse_settings = []
          resp['result'].each do |setting|
            parse_settings.push(
              SendGrid4r::REST::Webhooks::ParseApi.create_parse_setting(
                setting
              )
            )
          end
          ParseSettings.new(parse_settings)
        end

        def self.create_parse_setting(resp)
          return resp if resp.nil?
          ParseSetting.new(
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
