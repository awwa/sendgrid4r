# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Webhooks
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list without params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Parse.start(args)
      end

      it '#list with full params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--limit', 0,
          '--offset', 1
        ]
        Parse.start(args)
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--hostname', 'host1.abc.abc',
          '--url', 'http://host1.abc.abc',
          '--spam_check', true,
          '--send_raw', true
        ]
        Parse.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--hostname', 'host1.abc.abc'
        ]
        Parse.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--hostname', 'host1.abc.abc',
          '--url', 'http://host1.abc.abc',
          '--spam_check', true,
          '--send_raw', true
        ]
        Parse.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--hostname', 'host1.abc.abc'
        ]
        Parse.start(args)
      end
    end
  end
end
