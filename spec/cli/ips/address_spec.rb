# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ips
  describe Address do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#add_to_pool' do
        args = [
          'add_to_pool',
          '--apikey', ENV['SILVER_API_KEY'],
          '--pool_name', 'test_pool',
          '--ip', ENV['IP']
        ]
        Address.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Address.start(args)
      end

      it '#assigned' do
        args = [
          'assigned',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Address.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Address.start(args)
      end

      it '#delete_from_pool' do
        args = [
          'delete_from_pool',
          '--apikey', ENV['SILVER_API_KEY'],
          '--pool_name', 'test_pool',
          '--ip', ENV['IP']
        ]
        Address.start(args)
      end
    end
  end
end
