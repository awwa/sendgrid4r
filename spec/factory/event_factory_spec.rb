# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe EventFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it 'create with full parameters' do
        event = EventFactory.create(
          enabled: true, url: 'test.test.test', group_resubscribe: true,
          delivered: true, group_unsubscribe: true, spam_report: true,
          bounce: true, deferred: true, unsubscribe: true, processed: true,
          open: true, click: true, dropped: true)
        expect(event).to be_a(
          SendGrid4r::REST::Webhooks::Event::EventNotification
        )
        expect(event.enabled).to eq(true)
        expect(event.url).to eq('test.test.test')
        expect(event.group_resubscribe).to eq(true)
        expect(event.delivered).to eq(true)
        expect(event.group_unsubscribe).to eq(true)
        expect(event.spam_report).to eq(true)
        expect(event.bounce).to eq(true)
        expect(event.deferred).to eq(true)
        expect(event.unsubscribe).to eq(true)
        expect(event.processed).to eq(true)
        expect(event.open).to eq(true)
        expect(event.click).to eq(true)
        expect(event.dropped).to eq(true)
      end
    end
  end
end
