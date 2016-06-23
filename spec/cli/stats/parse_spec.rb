# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get with mandatory params' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01'
        ]
        Parse.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01',
          '--end-date', '2016-01-02',
          '--aggregated-by', 'day'
        ]
        Parse.start(args)
      end
    end
  end
end
