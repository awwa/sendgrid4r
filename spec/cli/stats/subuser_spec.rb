# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Subuser do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get with mandatory params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--subusers', ENV['SUBUSER4']
        ]
        Subuser.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day',
          '--subusers', ENV['SUBUSER4']
        ]
        Subuser.start(args)
      end

      it '#sums with mandatory params' do
        args = [
          'sums',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2015-01-01'
        ]
        Subuser.start(args)
      end

      it '#sums with full params' do
        args = [
          'sums',
          '--apikey', ENV['SILVER_API_KEY'],
          '--start_date', '2015-01-01',
          '--end_date', '2015-01-31',
          '--sort_by_metric', 'requests',
          '--sort_by_direction', 'desc',
          '--limit', 10,
          '--offset', 0
        ]
        Subuser.start(args)
      end

      it '#list_monthly with mandatory params' do
        args = [
          'list_monthly',
          '--apikey', ENV['SILVER_API_KEY'],
          '--date', '2015-01-01'
        ]
        Subuser.start(args)
      end

      it '#list_monthly with full params' do
        args = [
          'list_monthly',
          '--apikey', ENV['SILVER_API_KEY'],
          '--date', '2015-01-01',
          '--subuser', ENV['SUBUSER4'],
          '--sort_by_metric', 'requests',
          '--sort_by_direction', 'desc',
          '--limit', 10,
          '--offset', 0
        ]
        Subuser.start(args)
      end

      it '#get_monthly with mandatory params' do
        args = [
          'get_monthly',
          '--apikey', ENV['SILVER_API_KEY'],
          '--subuser', ENV['SUBUSER4'],
          '--date', '2015-01-01'
        ]
        Subuser.start(args)
      end

      it '#get_monthly with full params' do
        args = [
          'get_monthly',
          '--apikey', ENV['SILVER_API_KEY'],
          '--subuser', ENV['SUBUSER4'],
          '--date', '2015-01-01',
          '--sort_by_metric', 'requests',
          '--sort_by_direction', 'desc',
          '--limit', 10,
          '--offset', 0
        ]
        Subuser.start(args)
      end
    end
  end
end
