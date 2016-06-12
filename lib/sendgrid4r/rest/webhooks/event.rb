# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Webhooks
  #
  module Webhooks
    #
    # SendGrid Web API v3 Webhooks ParseApi
    #
    module Event
      include Request

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
        resp = get(@auth, Event.url_event(:settings), &block)
        finish(resp, @raw_resp) { |r| Event.create_event_notification(r) }
      end

      def patch_settings_event_notification(params:, &block)
        resp = patch(@auth, Event.url_event(:settings), params.to_h, &block)
        finish(resp, @raw_resp) { |r| Event.create_event_notification(r) }
      end

      def test_settings_event_notification(url:, &block)
        params = { url: url }
        post(@auth, Event.url_event(:test), params, &block)
      end
    end
  end
end
