# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ips
  describe Ip do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#address subcommand' do
        args = [
          'address'
        ]
        Ip.start(args)
      end

      it '#pool subcommand' do
        args = [
          'pool'
        ]
        Ip.start(args)
      end

      it '#warmup subcommand' do
        args = [
          'warmup'
        ]
        Ip.start(args)
      end
    end
  end
end
