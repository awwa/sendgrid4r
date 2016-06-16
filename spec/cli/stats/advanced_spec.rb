# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Stats
  describe Advanced do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#geo with mandatory params' do
        args = [
          'geo',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Advanced.start(args)
      end

      it '#geo with full params' do
        args = [
          'geo',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day',
          '--country', 'US'
        ]
        Advanced.start(args)
      end

      it '#device with mandatory params' do
        args = [
          'device',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Advanced.start(args)
      end

      it '#device with full params' do
        args = [
          'device',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day'
        ]
        Advanced.start(args)
      end

      it '#client with mandatory params' do
        args = [
          'client',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Advanced.start(args)
      end

      it '#client with full params' do
        args = [
          'client',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day'
        ]
        Advanced.start(args)
      end

      it '#client_type with mandatory params' do
        args = [
          'client_type',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--client_type', 'phone'
        ]
        Advanced.start(args)
      end

      it '#client_type with full params' do
        args = [
          'client_type',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day',
          '--client_type', 'phone'
        ]
        Advanced.start(args)
      end

      it '#mailbox_provider with mandatory params' do
        args = [
          'mailbox_provider',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Advanced.start(args)
      end

      it '#mailbox_provider with full params' do
        args = [
          'mailbox_provider',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day',
          '--mailbox_providers', 'gmail'
        ]
        Advanced.start(args)
      end

      it '#browser with mandatory params' do
        args = [
          'browser',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01'
        ]
        Advanced.start(args)
      end

      it '#browser with full params' do
        args = [
          'browser',
          '--api_key', ENV['SILVER_API_KEY'],
          '--start_date', '2016-01-01',
          '--end_date', '2016-01-02',
          '--aggregated_by', 'day',
          '--browsers', 'chrome'
        ]
        Advanced.start(args)
      end
    end
  end
end
