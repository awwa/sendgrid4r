# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Global do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get with mandatory params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Global.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day'
        ]
        Global.start(args)
      end
    end
  end
end
