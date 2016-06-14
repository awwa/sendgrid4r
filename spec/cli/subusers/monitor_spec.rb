# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Subusers
  describe Monitor do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4'],
        ]
        Monitor.start(args)
      end

      it '#create' do
        args = [
          'create',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4'],
          '--email', ENV['MAIL'],
          '--frequency', 10
        ]
        Monitor.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4'],
          '--email', ENV['MAIL'],
          '--frequency', 10
        ]
        Monitor.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4']
        ]
        Monitor.start(args)
      end
    end
  end
end
