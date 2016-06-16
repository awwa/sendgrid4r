# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ipam
  describe Whitelist do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Whitelist.start(args)
      end

      it '#add' do
        args = [
          'add',
          '--api_key', ENV['SILVER_API_KEY'],
          '--ips', '8.8.8.8'
        ]
        Whitelist.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api_key', ENV['SILVER_API_KEY'],
          '--ids', 6703438
        ]
        Whitelist.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api_key', ENV['SILVER_API_KEY'],
          '--rule_id', 6703438
        ]
        Whitelist.start(args)
      end
    end
  end
end
