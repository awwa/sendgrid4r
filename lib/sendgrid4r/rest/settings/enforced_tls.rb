# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Settings
      #
      # SendGrid Web API v3 Settings - EnforcedTls
      #
      module EnforcedTls
        include SendGrid4r::REST::Request
        EnforcedTls = Struct.new(:require_tls, :require_valid_cert)

        def self.create_enforced_tls(resp)
          return resp if resp.nil?
          EnforcedTls.new(resp['require_tls'], resp['require_valid_cert'])
        end

        def self.url
          "#{SendGrid4r::Client::BASE_URL}/user/settings/enforced_tls"
        end

        def get_enforced_tls(&block)
          resp = get(
            @auth,
            SendGrid4r::REST::Settings::EnforcedTls.url,
            &block
          )
          SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(resp)
        end

        def patch_enforced_tls(params, &block)
          resp = patch(
            @auth,
            SendGrid4r::REST::Settings::EnforcedTls.url,
            params.to_h,
            &block
          )
          SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(resp)
        end
      end
    end
  end
end
