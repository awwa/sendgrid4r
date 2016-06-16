# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::ApiKeys
  describe Permission do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Permission.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--username', ENV['USERNAME'],
          '--password', ENV['PASS']
        ]
        Permission.start(args)
      end
    end
  end
end
