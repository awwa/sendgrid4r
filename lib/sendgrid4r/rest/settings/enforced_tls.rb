# -*- encoding: utf-8 -*-


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
          "#{BASE_URL}/user/settings/enforced_tls"
        end

        def get_enforced_tls(&block)
          endpoint = SendGrid4r::REST::Settings::EnforcedTls.url
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(resp)
        end

        def patch_enforced_tls(params:, &block)
          endpoint = SendGrid4r::REST::Settings::EnforcedTls.url
          resp = patch(@auth, endpoint, params.to_h, &block)
          SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(resp)
        end
      end
    end
  end
end
