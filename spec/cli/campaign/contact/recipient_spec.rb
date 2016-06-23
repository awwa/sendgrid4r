# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::CLI::Campaign::Contact
  describe Recipient do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create multiple recipients' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--params', 'email:abc@abc.abc', 'last_name:cli taro'
        ]
        Recipient.start(args)
      end

      it '#create single recipient' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--params', "email:#{ENV['MAIL']}"
        ]
        Recipient.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['API_KEY'],
          '--params', 'email:abc@abc.abc', 'last_name:cli taro'
        ]
        Recipient.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['API_KEY'],
          '--recipient-ids', 'YWJjQGFiYy5hYmM='
        ]
        Recipient.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY'],
          '--page', 1,
          '--page-size', 50
        ]
        Recipient.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--recipient-id', 'YXd3YTUwMEBnbWFpbC5jb20='
        ]
        Recipient.start(args)
      end

      it '#count' do
        args = [
          'count',
          '--api-key', ENV['API_KEY']
        ]
        Recipient.start(args)
      end

      it '#search' do
        args = [
          'search',
          '--api-key', ENV['API_KEY'],
          '--params', 'email:abc@abc.abc'
        ]
        Recipient.start(args)
      end

      it '#belong' do
        args = [
          'belong',
          '--api-key', ENV['API_KEY'],
          '--recipient-id', 'YWJjQGFiYy5hYmM='
        ]
        Recipient.start(args)
      end
    end
  end
end
