# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ips
  describe Warmup do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Warmup.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end

      it '#start' do
        args = [
          'start',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end

      it '#stop' do
        args = [
          'stop',
          '--apikey', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end
    end
  end
end
