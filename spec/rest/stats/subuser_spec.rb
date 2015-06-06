# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Stats::Subuser do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      @subuser = ENV['SILVER_SUBUSER1']
    end

    context 'without block call' do
      it '#get_subusers_stats with mandatory params' do
        begin
          top_stats = @client.get_subusers_stats(
            start_date: '2015-01-01',
            subusers: @subuser
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |global_stat|
            expect(global_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            global_stat.stats.each do |stat|
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

      it '#get_subusers_stats with all params' do
        begin
          top_stats = @client.get_subusers_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
            subusers: @subuser
          )
          expect(top_stats.class).to be(Array)
          top_stats.each do |global_stat|
            expect(global_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            global_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_subusers_stats_sums with mandatory params' do
        begin
          top_stat = @client.get_subusers_stats_sums(start_date: '2015-01-01')
          expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_subusers_stats_sums with all params' do
        begin
          top_stat = @client.get_subusers_stats_sums(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            sort_by_metric: 'opens',
            sort_by_direction: 'desc',
            limit: 5,
            offset: 0
          )
          expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_subusers_stats with all params' do
        @client.get_subusers_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          subusers: @subuser
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

      it '#get_subusers_stats_sums with all params' do
        @client.get_subusers_stats_sums(
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
end
