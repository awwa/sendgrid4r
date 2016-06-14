# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Whitelabel
  describe Whitelabel do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#domain subcommand' do
        args = [
          'domain',
          'help'
        ]
        Whitelabel.start(args)
      end

      it '#link subcommand' do
        args = [
          'link'
        ]
        Whitelabel.start(args)
      end

      it '#ip subcommand' do
        args = [
          'ip'
        ]
        Whitelabel.start(args)
      end
    end
  end
end
