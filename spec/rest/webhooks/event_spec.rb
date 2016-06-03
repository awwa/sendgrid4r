# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Webhooks
  describe Event do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      end

      context 'without block call' do
        it '#get_settings_event_notification' do
          actual = @client.get_settings_event_notification
          expect(actual).to be_a(Event::EventNotification)
        end

        it '#patch_settings_event_notification' do
          # get original settings
          actual = @client.get_settings_event_notification
          # patch the value
          actual.enabled = false
          actual.url = 'http://www.google.com/?=test@test.com'
          actual.group_resubscribe = true
          actual.delivered = true
          actual.group_unsubscribe = true
          actual.spam_report = true
          actual.bounce = true
          actual.deferred = true
          actual.unsubscribe = true
          actual.processed = true
          actual.open = true
          actual.click = true
          actual.dropped = true
          edit = @client.patch_settings_event_notification(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.url).to eq('http://www.google.com/?=test@test.com')
          expect(edit.group_resubscribe).to eq(true)
          expect(edit.delivered).to eq(true)
          expect(edit.group_unsubscribe).to eq(true)
          expect(edit.spam_report).to eq(true)
          expect(edit.bounce).to eq(true)
          expect(edit.deferred).to eq(true)
          expect(edit.unsubscribe).to eq(true)
          expect(edit.processed).to eq(true)
          expect(edit.open).to eq(true)
          expect(edit.click).to eq(true)
          expect(edit.dropped).to eq(true)
        end

        it '#test_settings_event_notification' do
          @client.test_settings_event_notification(url: ENV['EVENT_URL'])
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:event_notification) do
        JSON.parse(
          '{'\
            '"enabled": true,'\
            '"url": "url",'\
            '"group_resubscribe": true,'\
            '"delivered": true,'\
            '"group_unsubscribe": true,'\
            '"spam_report": true,'\
            '"bounce": true,'\
            '"deferred": true,'\
            '"unsubscribe": true,'\
            '"processed": true,'\
            '"open": true,'\
            '"click": true,'\
            '"dropped": true'\
          '}'
        )
      end

      it '#get_settings_event_notification' do
        allow(client).to receive(:execute).and_return(event_notification)
        actual = client.get_settings_event_notification
        expect(actual).to be_a(Event::EventNotification)
      end

      it '#patch_settings_event_notification' do
        allow(client).to receive(:execute).and_return(event_notification)
        actual = client.patch_settings_event_notification(params: nil)
        expect(actual).to be_a(Event::EventNotification)
      end

      it 'creates event_notification instance' do
        actual = Event.create_event_notification(event_notification)
        expect(actual.enabled).to eq(true)
        expect(actual.url).to eq('url')
        expect(actual.group_resubscribe).to eq(true)
        expect(actual.delivered).to eq(true)
        expect(actual.group_unsubscribe).to eq(true)
        expect(actual.spam_report).to eq(true)
        expect(actual.bounce).to eq(true)
        expect(actual.deferred).to eq(true)
        expect(actual.unsubscribe).to eq(true)
        expect(actual.processed).to eq(true)
        expect(actual.open).to eq(true)
        expect(actual.click).to eq(true)
        expect(actual.dropped).to eq(true)
      end
    end
  end
end
