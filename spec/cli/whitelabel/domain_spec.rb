# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Whitelabel
  describe Domain do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0,
          '--exclude-subusers', '',
          '--username', '',
          '--domain', ''
        ]
        Domain.start(args)
      end

      it '#create with full params' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--domain', 'abc.ab',
          '--subdomain', 'em',
          '--automatic-security', true,
          '--custom-spf', false,
          '--default', false
        ]
        Domain.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 524753
        ]
        Domain.start(args)
      end

      it '#update with full params' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 524753,
          '--default', true
        ]
        Domain.start(args)
      end

      it '#delete with full params' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 524753
        ]
        Domain.start(args)
      end

      it '#default with full params' do
        args = [
          'default',
          '--api-key', ENV['SILVER_API_KEY'],
          '--domain', 'abc.ab'
        ]
        Domain.start(args)
      end

      it '#validate with full params' do
        args = [
          'validate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 524753
        ]
        Domain.start(args)
      end

      it '#list_associated with full params' do
        args = [
          'list_associate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER2']
        ]
        Domain.start(args)
      end

      it '#disassociate with full params' do
        args = [
          'disassociate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER2']
        ]
        Domain.start(args)
      end

      it '#associate with full params' do
        args = [
          'associate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 524753,
          '--username', ENV['SUBUSER2']
        ]
        Domain.start(args)
      end
    end
  end
end
