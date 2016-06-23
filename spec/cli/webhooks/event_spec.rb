# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Webhooks
  describe Event do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Event.start(args)
      end

      it '#enable with mandatory params' do
        args = [
          'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--group-resubscribe', true
        ]
        Event.start(args)
      end

      it '#enable with full params' do
        args = [
          'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--group-resubscribe', false,
          '--delivered', false,
          '--group-unsubscribe', false,
          '--spam-report', false,
          '--bounce', false,
          '--deferred', false,
          '--unsubscribe', false,
          '--processed', false,
          '--open', false,
          '--click', false,
          '--dropped', false
        ]
        Event.start(args)
      end

      it '#disable with full params' do
        args = [
          'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Event.start(args)
      end

      it '#test' do
        args = [
          'test',
          '--api-key', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test'
        ]
        Event.start(args)
      end
    end
  end
end
