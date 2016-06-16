# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Ipam
  describe Activity do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--limit', 20
        ]
        Activity.start(args)
      end
    end
  end
end
