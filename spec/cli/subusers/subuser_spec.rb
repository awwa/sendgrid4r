# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Subusers
  describe Subuser do
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
          '--username', 'blog.sgncsfn9@kke.com'
        ]
        Subuser.start(args)
      end

      it '#create with full params' do
        args = [
          'create',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4'],
          '--email', ENV['MAIL'],
          '--password', ENV['PASS'],
          '--ips', ENV['IP']
        ]
        Subuser.start(args)
      end

      it '#enable' do
        args = [
          'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4']
        ]
        Subuser.start(args)
      end

      it '#disable' do
        args = [
          'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4']
        ]
        Subuser.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4']
        ]
        Subuser.start(args)
      end

      it '#reputation' do
        args = [
          'reputation',
          '--apikey', ENV['SILVER_API_KEY'],
          '--usernames', ENV['SUBUSER4'], ENV['SUBUSER2']
        ]
        Subuser.start(args)
      end

      it '#assign_ips' do
        args = [
          'assign_ips',
          '--apikey', ENV['SILVER_API_KEY'],
          '--username', ENV['SUBUSER4'],
          '--ips', ENV['IP']
        ]
        Subuser.start(args)
      end

      it '#monitor subcommand' do
        args = [
          'monitor'
        ]
        Subuser.start(args)
      end
    end
  end
end