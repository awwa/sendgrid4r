# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe GlobalUnsubscribe do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with no params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        GlobalUnsubscribe.start(args)
      end

      it '#list with full params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-time', Time.local(2016, 1, 1).to_i,
          '--end-time', Time.local(2016, 1, 31).to_i,
          '--limit', 10,
          '--offset', 0
        ]
        GlobalUnsubscribe.start(args)
      end

      it '#add' do
        args = [
          'add',
          '--api-key', ENV['SILVER_API_KEY'],
          '--emails', 'abc@abc.com', 'cde@cde.com'
        ]
        GlobalUnsubscribe.start(args)
      end

      it '#delete with email' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', 'abc@abc.com'
        ]
        GlobalUnsubscribe.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', 'cde@cde.com'
        ]
        GlobalUnsubscribe.start(args)
      end
    end
  end
end
