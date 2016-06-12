# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Whitelabel
  describe Ip do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP'],
          '--limit', 2,
          '--offset', 0
        ]
        Ip.start(args)
      end

      it '#create with full params' do
        args = [
          'create',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', '198.37.155.196',
          '--domain', 'abc',
          '--subdomain', 'cde'
        ]
        Ip.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 24743
        ]
        Ip.start(args)
      end

      it '#delete with full params' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 1
        ]
        Ip.start(args)
      end

      it '#validate with full params' do
        args = [
          'validate',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 24743
        ]
        Ip.start(args)
      end
    end
  end
end
