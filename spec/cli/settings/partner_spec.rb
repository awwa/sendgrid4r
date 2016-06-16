# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Settings
  describe Partner do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--api_key', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0
        ]
        Partner.start(args)
      end

      it '#new_relic get' do
        args = [
          'new_relic', 'get',
          '--api_key', ENV['SILVER_API_KEY'],
        ]
        Partner.start(args)
      end

      it '#new_relic enable' do
        args = [
          'new_relic', 'enable',
          '--api_key', ENV['SILVER_API_KEY'],
          '--license_key', 'aaa'
        ]
        Partner.start(args)
      end

      it '#new_relic disable' do
        args = [
          'new_relic', 'disable',
          '--api_key', ENV['SILVER_API_KEY'],
        ]
        Partner.start(args)
      end
    end
  end
end
