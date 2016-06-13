# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Supressions
  describe Supression do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#block subcommand' do
        args = [
          'block',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#bounce subcommand' do
        args = [
          'bounce',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#invalid_email subcommand' do
        args = [
          'invalid_email',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#spam_report subcommand' do
        args = [
          'spam_report',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#global_unsubscribe subcommand' do
        args = [
          'global_unsubscribe',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#group subcommand' do
        args = [
          'group',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end

      it '#group_unsubscribe subcommand' do
        args = [
          'group_unsubscribe',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Supression.start(args)
      end
    end
  end
end
