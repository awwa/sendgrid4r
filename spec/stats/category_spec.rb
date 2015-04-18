# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Stats::Category do
  before do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
  end

  context 'without block call' do
    it '#get_categories_stats with mandatory params' do
      begin
        actual = @client.get_categories_stats(
          start_date: '2015-01-01',
          categories: 'yui'
        )
        expect(actual).to be_a(Array)
        expect(actual.length).to be > 0
        actual.each do |global_stat|
          expect(global_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each do |stat|
            expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
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
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_category_stats with all params' do
      begin
        actual = @client.get_categories_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          categories: 'yui'
        )
        expect(actual).to be_a(Array)
        expect(actual.length).to be > 0
        actual.each do |global_stat|
          expect(global_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each do |stat|
            expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
          end
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_categories_stats_sums with mandatory params' do
      begin
        actual = @client.get_categories_stats_sums(start_date: '2015-01-01')
        expect(actual).to be_a(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to be > 0
        stats.each do |stat|
          expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
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
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_categories_stats_sums with all params' do
      begin
        actual = @client.get_categories_stats_sums(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          sort_by_metric: 'opens',
          sort_by_direction: 'desc',
          limit: 5,
          offset: 0
        )
        expect(actual).to be_a(SendGrid4r::REST::Stats::TopStat)
        stats = actual.stats
        expect(stats.length).to eq(0)
        stats.each do |stat|
          expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics_a).to be(SendGrid4r::REST::Stats::Metric)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    it '#get_category_stats with all params' do
      @client.get_categories_stats(
        start_date: '2015-01-01',
        end_date: '2015-01-02',
        aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
        categories: 'yui'
      ) do |resp, req, res|
        resp =
          SendGrid4r::REST::Stats.create_top_stats(
            JSON.parse(resp)
          )
        expect(resp).to be_a(Array)
        resp.each do |stat|
          expect(stat).to be_a(SendGrid4r::REST::Stats::TopStat)
        end
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_categories_stats_sums with all params' do
      @client.get_categories_stats_sums(
        start_date: '2015-01-01',
        end_date: '2015-01-02',
        sort_by_metric: 'opens',
        sort_by_direction: 'desc',
        limit: 5,
        offset: 0
      ) do |resp, req, res|
        resp =
          SendGrid4r::REST::Stats.create_top_stat(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Stats::TopStat)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end
  end
end
