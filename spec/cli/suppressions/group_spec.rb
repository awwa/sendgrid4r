# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe Group do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'thor_test',
          '--description', 'thor test description',
          '--is-default', false
        ]
        Group.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Group.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 889
        ]
        Group.start(args)
      end

      it '#update with mandatory params' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 967
        ]
        Group.start(args)
      end

      it '#update with full params' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 967,
          '--name', 'thor test 2',
          '--description', 'thor test description 2'
        ]
        Group.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--group-id', 967
        ]
        Group.start(args)
      end
    end
  end
end
