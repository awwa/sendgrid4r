# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Settings
    #
    # SendGrid Web API v3 Settings - Partner
    #
    module Partner
      include Request

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
        params[:limit] = limit unless limit.nil?
        params[:offset] = offset unless offset.nil?
        resp = get(@auth, Settings::Partner.url, params, &block)
        finish(resp, @raw_resp) { |r| Settings.create_results(r) }
      end

      def get_settings_new_relic(&block)
        resp = get(@auth, Settings::Partner.url(:new_relic), &block)
        finish(resp, @raw_resp) { |r| Settings::Partner.create_partner(r) }
      end

      def patch_settings_new_relic(params:, &block)
        endpoint = Settings::Partner.url(:new_relic)
        resp = patch(@auth, endpoint, params.to_h, &block)
        finish(resp, @raw_resp) { |r| Settings::Partner.create_partner(r) }
      end
    end
  end
end
