# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Whitelabel
  describe Link do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0,
          '--exclude_subusers', '',
          '--username', '',
          '--domain', ''
        ]
        Link.start(args)
      end

      it '#create with full params' do
        args = [
          'create',
          '--apikey', ENV['SILVER_API_KEY'],
          '--domain', 'abc.ab',
          '--subdomain', 'link',
          '--default', false
        ]
        Link.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 558172
        ]
        Link.start(args)
      end

      it '#update with full params' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 558172,
          '--default', true
        ]
        Link.start(args)
      end

      it '#delete with full params' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 558172
        ]
        Link.start(args)
      end

      it '#default with full params' do
        args = [
          'default',
          '--apikey', ENV['SILVER_API_KEY'],
          '--domain', 'abc.ab'
        ]
        Link.start(args)
      end

      it '#validate with full params' do
        args = [
          'validate',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 558172
        ]
        Link.start(args)
      end

      it '#list_associated with full params' do
        args = [
          'list_associate',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER2']
        ]
        Link.start(args)
      end

      it '#disassociate with full params' do
        args = [
          'disassociate',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER2']
        ]
        Link.start(args)
      end

      it '#associate with full params' do
        args = [
          'associate',
          '--apikey', ENV['SILVER_API_KEY'],
          '--id', 558172,
          '--username', ENV['SUBUSER2']
        ]
        Link.start(args)
      end
    end
  end
end
