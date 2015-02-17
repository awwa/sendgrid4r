# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Settings
      module EnforcedTls

        include SendGrid4r::REST::Request
        EnforcedTls = Struct.new(:require_tls, :require_valid_cert)

        def self.create_enforced_tls(resp)
          EnforcedTls.new(resp["require_tls"], resp["require_valid_cert"])
        end

        def get_enforced_tls
          resp = get(@auth, "#{SendGrid4r::Client::BASE_URL}/user/settings/enforced_tls")
          SendGrid4r::REST::Settings::EnforcedTls::create_enforced_tls(resp)
        end

        def patch_enforced_tls(params)
          resp = patch(
            @auth, "#{SendGrid4r::Client::BASE_URL}/user/settings/enforced_tls", params.to_h)
          SendGrid4r::REST::Settings::EnforcedTls::create_enforced_tls(resp)
        end

      end
    end
  end
end
