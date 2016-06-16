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
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Warmup.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end

      it '#start' do
        args = [
          'start',
          '--api-key', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end

      it '#stop' do
        args = [
          'stop',
          '--api-key', ENV['SILVER_API_KEY'],
          '--ip', ENV['IP']
        ]
        Warmup.start(args)
      end
    end
  end
end
