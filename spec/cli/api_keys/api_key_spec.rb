# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::ApiKeys
  describe ApiKey do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        ApiKey.start(args)
      end

      it '#create with scope' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'api_key_test3',
          '--scopes', 'mail.send'
        ]
        ApiKey.start(args)
      end

      it '#create with all scope' do
        args = [
          'create',
          '--user', ENV['USERNAME'],
          '--pass', ENV['PASS'],
          '--name', 'api_key_test4'
        ]
        ApiKey.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--api-key-id', ENV['TEMP_API_KEY_ID']
        ]
        ApiKey.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--api-key-id', ENV['TEMP_API_KEY_ID']
        ]
        ApiKey.start(args)
      end

      it '#update specify scopes' do
        args = [
          'update',
          '--user', ENV['USERNAME'],
          '--pass', ENV['PASS'],
          '--name', 'api_key_test31',
          '--api-key-id', ENV['TEMP_API_KEY_ID'],
          '--scopes', 'mail.batch.create', 'mail.send'
        ]
        ApiKey.start(args)
      end

      it '#permission subcommand' do
        args = [
          'permission'
        ]
        ApiKey.start(args)
      end
    end
  end
end
