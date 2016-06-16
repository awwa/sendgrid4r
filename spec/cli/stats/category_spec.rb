# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Category do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get with mandatory params' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01',
          '--categories', 'cat1'
        ]
        Category.start(args)
      end

      it '#get with full params' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01',
          '--end-date', '2016-01-02',
          '--aggregated-by', 'day',
          '--categories', 'cat1'
        ]
        Category.start(args)
      end

      it '#sums with mandatory params' do
        args = [
          'sums',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01'
        ]
        Category.start(args)
      end

      it '#sums with full params' do
        args = [
          'sums',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-date', '2016-01-01',
          '--end-date', '2016-01-02',
          '--sort-by-metric', 'requests',
          '--sort-by-direction', 'desc',
          '--limit', 10,
          '--offset', 0
        ]
        Category.start(args)
      end
    end
  end
end
