# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Webhooks
  #
  module Webhooks
    #
    # SendGrid Web API v3 Webhooks Parse
    #
    module Parse
      include Request

      ParseSettings = Struct.new(:result)
      ParseSetting = Struct.new(:url, :hostname, :spam_check, :send_raw)

      def self.url(hostname = nil)
        url = "#{BASE_URL}/user/webhooks/parse/settings"
        url = "#{url}/#{hostname}" unless hostname.nil?
        url
      end

      def self.create_parse_settings(resp)
        return resp if resp.nil?
        parse_settings = resp['result'].map do |setting|
          Parse.create_parse_setting(setting)
        end
        ParseSettings.new(parse_settings)
      end

      def self.create_parse_setting(resp)
        return resp if resp.nil?
        ParseSetting.new(
          resp['url'],
          resp['hostname'],
          resp['spam_check'],
          resp['send_raw']
        )
      end

      def get_parse_settings(limit: nil, offset: nil, &block)
        params = {}
        params[:limit] = limit unless limit.nil?
        params[:offset] = offset unless offset.nil?
        resp = get(@auth, Parse.url, params, &block)
        finish(resp, @raw_resp) { |r| Parse.create_parse_settings(r) }
      end

      def post_parse_setting(
        hostname:, url:, spam_check:, send_raw:, &block
      )
        params = {
          hostname: hostname,
          url: url,
          spam_check: spam_check,
          send_raw: send_raw
        }
        resp = post(@auth, Parse.url, params, &block)
        finish(resp, @raw_resp) { |r| Parse.create_parse_setting(r) }
      end

      def get_parse_setting(hostname:, &block)
        resp = get(@auth, Parse.url(hostname), &block)
        finish(resp, @raw_resp) { |r| Parse.create_parse_setting(r) }
      end

      def patch_parse_setting(
        hostname:, url: nil, spam_check: nil, send_raw: nil, &block
      )
        params = {}
        params[:url] = url unless url.nil?
        params[:spam_check] = spam_check unless spam_check.nil?
        params[:send_raw] = send_raw unless send_raw.nil?
        resp = patch(@auth, Parse.url(hostname), params, &block)
        finish(resp, @raw_resp) { |r| Parse.create_parse_setting(r) }
      end

      def delete_parse_setting(hostname:, &block)
        delete(@auth, Parse.url(hostname), &block)
      end
    end
  end
end
