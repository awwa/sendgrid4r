# -*- encoding: utf-8 -*-

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Settings
      #
      # SendGrid Web API v3 Settings - Partner
      #
      module Partner
        include SendGrid4r::REST::Request
        Partner = Struct.new(:enabled, :license_key)

        def self.create_partner(resp)
          return resp if resp.nil?
          Partner.new(resp['enabled'], resp['license_key'])
        end

        def self.url(name = nil)
          url = "#{BASE_URL}/partner_settings"
          url = "#{url}/#{name}" unless name.nil?
          url
        end

        def get_partner_settings(limit: nil, offset: nil, &block)
          params = {}
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless offset.nil?
          endpoint = SendGrid4r::REST::Settings::Partner.url
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Settings.create_results(resp)
        end

        def get_settings_new_relic(&block)
          endpoint = SendGrid4r::REST::Settings::Partner.url('new_relic')
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Settings::Partner.create_partner(resp)
        end

        def patch_settings_new_relic(params:, &block)
          endpoint = SendGrid4r::REST::Settings::Partner.url('new_relic')
          resp = patch(@auth, endpoint, params.to_h, &block)
          SendGrid4r::REST::Settings::Partner.create_partner(resp)
        end
      end
    end
  end
end
