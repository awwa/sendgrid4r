# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::CLI
  describe User do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#profile get with full params' do
        args = [
          'profile', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        User.start(args)
      end

      it '#profile update' do
        args = [
          'profile', 'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--city', 'Nakano2',
          '--zip', '111-1111'
        ]
        User.start(args)
      end

      it '#account get' do
        args = [
          'account', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        User.start(args)
      end

      it '#email get' do
        args = [
          'email', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        User.start(args)
      end

      it '#email update' do
        args = [
          'email', 'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL2']
        ]
        User.start(args)
      end

      it '#username get' do
        args = [
          'username', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        User.start(args)
      end

      it '#username update' do
        args = [
          'username', 'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--username', ENV['USERNAME']
        ]
        User.start(args)
      end

      it '#password' do
        args = [
          'password', 'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--new-password', ENV['PASS'],
          '--old-password', ENV['PASS']
        ]
        User.start(args)
      end
    end
  end
end
