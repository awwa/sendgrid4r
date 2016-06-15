# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Settings
  describe Settings do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#enforced_tls subcommand' do
        args = [
          'enforced_tls'
        ]
        Settings.start(args)
      end

      it '#mail subcommand' do
        args = [
          'mail'
        ]
        Settings.start(args)
      end

      it '#partner subcommand' do
        args = [
          'partner'
        ]
        Settings.start(args)
      end

      it '#tracking subcommand' do
        args = [
          'tracking'
        ]
        Settings.start(args)
      end
    end
  end
end
