module SendGrid4r::CLI
  module Webhooks
    #
    # SendGrid Web API v3 Webhooks Event
    #
    class Event < SgThor
      desc 'get', 'Get Event Webhook Settings'
      def get
        puts @client.get_settings_event_notification
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'enable', 'Enable Event Webhook Settings'
      option :url
      option :group_resubscribe, type: :boolean
      option :delivered, type: :boolean
      option :group_unsubscribe, type: :boolean
      option :spam_report, type: :boolean
      option :bounce, type: :boolean
      option :deferred, type: :boolean
      option :unsubscribe, type: :boolean
      option :processed, type: :boolean
      option :open, type: :boolean
      option :click, type: :boolean
      option :dropped, type: :boolean
      def enable
        params = parameterise(options)
        params[:enabled] = true
        event = SendGrid4r::Factory::EventFactory.create(params)
        puts @client.patch_settings_event_notification(params: event)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disable', 'Disable Event Webhook Settings'
      def disable
        params = { enabled: false }
        puts @client.patch_settings_event_notification(params: params)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'test', 'Sends a fake event notification post to the provided URL'
      option :url
      def test
        puts @client.test_settings_event_notification(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
