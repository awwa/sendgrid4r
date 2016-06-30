# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::CLI
  describe Alert do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Alert.start(args)
      end

      it '#create stats_notification alert' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--type', 'stats_notification',
          '--email_to', ENV['MAIL'],
          '--frequency', 'daily'
        ]
        Alert.start(args)
      end

      it '#create usage_limit alert' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--type', 'usage_limit',
          '--email_to', ENV['MAIL'],
          '--percentage', 50
        ]
        Alert.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--alert-id', 322729
        ]
        Alert.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--alert-id', 322729
        ]
        Alert.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--alert-id', 322729,
          '--email_to', ENV['MAIL'],
          '--percentage', 88
        ]
        Alert.start(args)
      end
    end
  end
end
