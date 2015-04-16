# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Stats::Advanced' do
  before :all do
    Dotenv.load
    # @client = SendGrid4r::Client.new(
    #   ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    @client = SendGrid4r::Client.new(
      ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
  end

  context 'without block call' do
    it '#get_geo_stats' do
      it 'returns geo stats if specify mandatory params' do
        actual = @client.get_geo_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.clicks.nil?).to be(false)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.unique_clicks.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
          end
        end
      end
      it 'returns geo stats if specify all params' do
        actual = @client.get_geo_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          country: 'US'
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_devices_stats' do
      it 'returns devices stats if specify mandatory params' do
        actual = @client.get_devices_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
          end
        end
      end
      it 'returns devices stats if specify all params' do
        actual = @client.get_devices_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_clients_stats' do
      it 'returns clients stats if specify mandatory params' do
        actual = @client.get_clients_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
          end
        end
      end
      it 'returns clients stats if specify all params' do
        actual = @client.get_clients_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_clients_type_stats' do
      it 'returns clients type stats if specify mandatory params' do
        actual = @client.get_clients_type_stats(
          start_date: '2015-01-01', client_type: 'webmail'
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
          end
        end
      end
      it 'returns clients type stats if specify all params' do
        actual = @client.get_clients_type_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          client_type: 'webmail'
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_esp_stats' do
      it 'returns esp stats if specify mandatory params' do
        actual = @client.get_esp_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.blocks.nil?).to be(false)
            expect(stat.metrics.bounces.nil?).to be(false)
            expect(stat.metrics.clicks.nil?).to be(false)
            expect(stat.metrics.deferred.nil?).to be(false)
            expect(stat.metrics.delivered.nil?).to be(false)
            expect(stat.metrics.drops.nil?).to be(false)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.spam_reports.nil?).to be(false)
            expect(stat.metrics.unique_clicks.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
          end
        end
      end
      it 'returns esp stats if specify all params' do
        actual = @client.get_esp_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          esps: 'sss'
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_browsers_stats' do
      it 'returns browsers stats if specify mandatory params' do
        actual = @client.get_browsers_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to be >= 0
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.clicks.nil?).to be(false)
            expect(stat.metrics.unique_clicks.nil?).to be(false)
          end
        end
      end
      it 'returns browsers stats if specify all params' do
        actual = @client.get_browsers_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          browsers: 'chrome'
        )
        expect(actual.class).to be(Array)
        expect(actual.length).to be >= 0
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
  end
end
