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
      module Event
        include SendGrid4r::REST::Request

        def self.url_event(path)
          "#{BASE_URL}/user/webhooks/event/#{path}"
        end

        EventNotification = Struct.new(
          :enabled, :url, :group_resubscribe, :delivered, :group_unsubscribe,
          :spam_report, :bounce, :deferred, :unsubscribe, :processed, :open,
          :click, :dropped
        )

        def self.create_event_notification(resp)
          return resp if resp.nil?
          EventNotification.new(
            resp['enabled'], resp['url'], resp['group_resubscribe'],
            resp['delivered'], resp['group_unsubscribe'], resp['spam_report'],
            resp['bounce'], resp['deferred'], resp['unsubscribe'],
            resp['processed'], resp['open'], resp['click'], resp['dropped']
          )
        end

        def get_settings_event_notification(&block)
          endpoint = SendGrid4r::REST::Webhooks::Event.url_event('settings')
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Webhooks::Event.create_event_notification(resp)
        end

        def patch_settings_event_notification(params:, &block)
          endpoint = SendGrid4r::REST::Webhooks::Event.url_event('settings')
          resp = patch(@auth, endpoint, params.to_h, &block)
          SendGrid4r::REST::Webhooks::Event.create_event_notification(resp)
        end

        def test_settings_event_notification(url:, &block)
          params = {}
          params['url'] = url
          endpoint = SendGrid4r::REST::Webhooks::Event.url_event('test')
          post(@auth, endpoint, params, &block)
        end
      end
    end
  end
end
