# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Stats do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#advanced subcommand' do
        args = [
          'advanced'
        ]
        Stats.start(args)
      end

      it '#global subcommand' do
        args = [
          'global'
        ]
        Stats.start(args)
      end

      it '#parse subcommand' do
        args = [
          'parse'
        ]
        Stats.start(args)
      end

      it '#subuser subcommand' do
        args = [
          'subuser'
        ]
        Stats.start(args)
      end
    end
  end
end
