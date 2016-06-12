# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Settings
    #
    # SendGrid Web API v3 Settings - EnforcedTls
    #
    module EnforcedTls
      include Request

      EnforcedTls = Struct.new(:require_tls, :require_valid_cert)

      def self.create_enforced_tls(resp)
        return resp if resp.nil?
        EnforcedTls.new(resp['require_tls'], resp['require_valid_cert'])
      end

      def self.url
        "#{BASE_URL}/user/settings/enforced_tls"
      end

      def get_enforced_tls(&block)
        resp = get(@auth, Settings::EnforcedTls.url, &block)
        finish(resp, @raw_resp) do |r|
          Settings::EnforcedTls.create_enforced_tls(r)
        end
      end

      def patch_enforced_tls(params:, &block)
        resp = patch(@auth, Settings::EnforcedTls.url, params.to_h, &block)
        finish(resp, @raw_resp) do |r|
          Settings::EnforcedTls.create_enforced_tls(r)
        end
      end
    end
  end
end
