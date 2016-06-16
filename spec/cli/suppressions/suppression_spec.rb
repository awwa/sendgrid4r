# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe Suppression do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#block subcommand' do
        args = [
          'block',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#bounce subcommand' do
        args = [
          'bounce',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#invalid_email subcommand' do
        args = [
          'invalid_email',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#spam_report subcommand' do
        args = [
          'spam_report',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#global_unsubscribe subcommand' do
        args = [
          'global_unsubscribe',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#group subcommand' do
        args = [
          'group',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end

      it '#group_unsubscribe subcommand' do
        args = [
          'group_unsubscribe',
          '--api_key', ENV['SILVER_API_KEY']
        ]
        Suppression.start(args)
      end
    end
  end
end
