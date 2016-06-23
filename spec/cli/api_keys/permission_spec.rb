# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::ApiKeys
  describe Permission do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with api key' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Permission.start(args)
      end

      it '#list with user and pass' do
        args = [
          'list',
          '--user', ENV['USERNAME'],
          '--pass', ENV['PASS']
        ]
        Permission.start(args)
      end
    end
  end
end
