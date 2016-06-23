# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Event Factory Class implementation
    #
    module EventFactory
      def self.create(enabled:, url: nil, group_resubscribe: nil,
        delivered: nil, group_unsubscribe: nil, spam_report: nil,
        bounce: nil, deferred: nil, unsubscribe: nil, processed: nil,
        open: nil, click: nil, dropped: nil)
        REST::Webhooks::Event::EventNotification.new(
          enabled, url, group_resubscribe, delivered,
          group_unsubscribe, spam_report, bounce, deferred,
          unsubscribe, processed, open, click, dropped
        )
      end
    end
  end
end
