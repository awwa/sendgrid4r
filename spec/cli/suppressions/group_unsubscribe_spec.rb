# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe GroupUnsubscribe do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#add' do
        args = [
          'add',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 1099,
          '--recipient-emails', 'abc@abc.com', 'cde@cde.com'
        ]
        GroupUnsubscribe.start(args)
      end

      it '#list with no params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 1099
        ]
        GroupUnsubscribe.start(args)
      end

      it '#search' do
        args = [
          'search',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 1099,
          '--recipient-emails', 'abc@abc.com', 'cde@cde.com'
        ]
        GroupUnsubscribe.start(args)
      end

      it '#remove' do
        args = [
          'remove',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 889,
          '--email-address', 'abc@abc.com'
        ]
        GroupUnsubscribe.start(args)
      end
    end
  end
end
