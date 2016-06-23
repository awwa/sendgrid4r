# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ips
  describe Pool do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'cli_pool_name'
        ]
        Pool.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Pool.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'cli_pool_name'
        ]
        Pool.start(args)
      end

      it '#rename' do
        args = [
          'rename',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'cli_pool_name',
          '--new-name', 'cli_pool_name_edit'
        ]
        Pool.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'cli_pool_name_edit'
        ]
        Pool.start(args)
      end
    end
  end
end
