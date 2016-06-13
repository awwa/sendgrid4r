# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Supressions
  describe Group do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--apikey', ENV['SILVER_API_KEY'],
          '--name', 'thor_test',
          '--description', 'thor test description',
          '--is_default', false
        ]
        Group.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Group.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--group_id', 967
        ]
        Group.start(args)
      end

      it '#update with mandatory params' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--group_id', 967
        ]
        Group.start(args)
      end

      it '#update with full params' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--group_id', 967,
          '--name', 'thor test 2',
          '--description', 'thor test description 2'
        ]
        Group.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--group_id', 967
        ]
        Group.start(args)
      end
    end
  end
end
