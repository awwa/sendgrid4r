# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Settings
    #
    # SendGrid Web API v3 Settings - Tracking
    #
    module Tracking
      include Request

      Click = Struct.new(:enabled)

      def self.create_click(resp)
        return resp if resp.nil?
        Click.new(resp['enabled'])
      end

      GoogleAnalytics = Struct.new(
        :enabled, :utm_source, :utm_medium, :utm_term, :utm_content,
        :utm_campaign
      )

      def self.create_google_analytics(resp)
        return resp if resp.nil?
        GoogleAnalytics.new(
          resp['enabled'], resp['utm_source'], resp['utm_medium'],
          resp['utm_term'], resp['utm_content'], resp['utm_campaign']
        )
      end

      Open = Struct.new(:enabled)

      def self.create_open(resp)
        return resp if resp.nil?
        Open.new(resp['enabled'])
      end

      Subscription = Struct.new(
        :enabled, :landing, :url, :replace, :html_content, :plain_content
      )

      def self.create_subscription(resp)
        return resp if resp.nil?
        Subscription.new(
          resp['enabled'], resp['landing'], resp['url'], resp['replace'],
          resp['html_content'], resp['plain_content']
        )
      end

      def self.url(name = nil)
        url = "#{BASE_URL}/tracking_settings"
        url = "#{url}/#{name}" unless name.nil?
        url
      end

      def get_tracking_settings(limit: nil, offset: nil, &block)
        params = {}
        params[:limit] = limit unless limit.nil?
        params[:offset] = offset unless offset.nil?
        resp = get(@auth, Settings::Tracking.url, params, &block)
        Settings.create_results(resp)
      end

      def get_settings_click(&block)
        resp = get(@auth, Settings::Tracking.url(:click), &block)
        Settings::Tracking.create_click(resp)
      end

      def patch_settings_click(params:, &block)
        endpoint = Settings::Tracking.url(:click)
        resp = patch(@auth, endpoint, params.to_h, &block)
        Settings::Tracking.create_click(resp)
      end

      def get_settings_google_analytics(&block)
        endpoint = Settings::Tracking.url(:google_analytics)
        resp = get(@auth, endpoint, &block)
        Settings::Tracking.create_google_analytics(resp)
      end

      def patch_settings_google_analytics(params:, &block)
        endpoint = Settings::Tracking.url(:google_analytics)
        resp = patch(@auth, endpoint, params.to_h, &block)
        Settings::Tracking.create_google_analytics(resp)
      end

      def get_settings_open(&block)
        resp = get(@auth, Settings::Tracking.url(:open), &block)
        Settings::Tracking.create_open(resp)
      end

      def patch_settings_open(params:, &block)
        resp = patch(@auth, Settings::Tracking.url(:open), params.to_h, &block)
        Settings::Tracking.create_open(resp)
      end

      def get_settings_subscription(&block)
        endpoint = Settings::Tracking.url(:subscription)
        resp = get(@auth, endpoint, &block)
        Settings::Tracking.create_subscription(resp)
      end

      def patch_settings_subscription(params:, &block)
        endpoint = Settings::Tracking.url(:subscription)
        resp = patch(@auth, endpoint, params.to_h, &block)
        Settings::Tracking.create_subscription(resp)
      end
    end
  end
end
