# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Stats::Cateogry' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
  end

  context 'always' do
    describe '#get_categories_stats' do
      it 'returns categories stats if specify mandatory params' do
        actual = @client.get_categories_stats(
          start_date: '2015-01-01',
          categories: 'yui'
        )
        expect(actual.class).to be(Array)
        expect(actual.length > 0).to be(true)
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.blocks.nil?).to be(false)
            expect(stat.metrics.bounce_drops.nil?).to be(false)
            expect(stat.metrics.bounces.nil?).to be(false)
            expect(stat.metrics.clicks.nil?).to be(false)
            expect(stat.metrics.deferred.nil?).to be(false)
            expect(stat.metrics.delivered.nil?).to be(false)
            expect(stat.metrics.invalid_emails.nil?).to be(false)
            expect(stat.metrics.opens.nil?).to be(false)
            expect(stat.metrics.processed.nil?).to be(false)
            expect(stat.metrics.requests.nil?).to be(false)
            expect(stat.metrics.spam_report_drops.nil?).to be(false)
            expect(stat.metrics.spam_reports.nil?).to be(false)
            expect(stat.metrics.unique_clicks.nil?).to be(false)
            expect(stat.metrics.unique_opens.nil?).to be(false)
            expect(stat.metrics.unsubscribe_drops.nil?).to be(false)
            expect(stat.metrics.unsubscribes.nil?).to be(false)
          end
        end
      end
      it 'returns categories stats if specify all params' do
        actual = @client.get_categories_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          categories: 'yui'
        )
        expect(actual.class).to be(Array)
        expect(actual.length > 0).to be(true)
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          end
        end
      end
    end
    describe '#get_categories_stats_sums' do
      it 'returns categories stats sums if specify mandatory params' do
        actual = @client.get_categories_stats_sums(start_date: '2015-01-01')
        expect(actual.class).to be(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to eq(3)
        stats.each do |stat|
          expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
          expect(stat.metrics.blocks.nil?).to be(false)
          expect(stat.metrics.bounce_drops.nil?).to be(false)
          expect(stat.metrics.bounces.nil?).to be(false)
          expect(stat.metrics.clicks.nil?).to be(false)
          expect(stat.metrics.deferred.nil?).to be(false)
          expect(stat.metrics.delivered.nil?).to be(false)
          expect(stat.metrics.invalid_emails.nil?).to be(false)
          expect(stat.metrics.opens.nil?).to be(false)
          expect(stat.metrics.processed.nil?).to be(false)
          expect(stat.metrics.requests.nil?).to be(false)
          expect(stat.metrics.spam_report_drops.nil?).to be(false)
          expect(stat.metrics.spam_reports.nil?).to be(false)
          expect(stat.metrics.unique_clicks.nil?).to be(false)
          expect(stat.metrics.unique_opens.nil?).to be(false)
          expect(stat.metrics.unsubscribe_drops.nil?).to be(false)
          expect(stat.metrics.unsubscribes.nil?).to be(false)
        end
      end
      it 'returns categories stats sums if specify all params' do
        actual = @client.get_categories_stats_sums(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          sort_by_metric: 'opens',
          sort_by_direction: 'desc',
          limit: 5,
          offset: 0
        )
        expect(actual.class).to be(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to eq(0)
        stats.each do |stat|
          expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
        end
      end
    end
  end
end
