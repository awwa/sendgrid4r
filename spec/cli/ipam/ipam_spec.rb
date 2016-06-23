# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ipam
  describe Ipam do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#activity subcommand' do
        args = [
          'activity'
        ]
        Ipam.start(args)
      end

      it '#whitelist subcommand' do
        args = [
          'whitelist'
        ]
        Ipam.start(args)
      end
    end
  end
end
