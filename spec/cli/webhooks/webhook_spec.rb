# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Webhooks
  describe Webhook do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#event subcommand' do
        args = [
          'event',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Webhook.start(args)
      end

      it '#parse subcommand' do
        args = [
          'parse',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Webhook.start(args)
      end
    end
  end
end
