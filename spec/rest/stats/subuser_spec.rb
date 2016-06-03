# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Stats
  describe Subuser do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @subuser = ENV['SUBUSER2']
        @email1 = ENV['MAIL']
        @password1 = ENV['PASS']
        @ip = ENV['IP']
        subusers = @client.get_subusers
        count = subusers.count { |subuser| subuser.username == @subuser }
        @client.post_subuser(
          username: @subuser,
          email: @email1,
          password: @password1,
          ips: [@ip]
        ) if count == 0
      end

      context 'without block call' do
        it '#get_subusers_stats with mandatory params' do
          top_stats = @client.get_subusers_stats(
            start_date: '2015-01-01',
            subusers: @subuser
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |global_stat|
            expect(global_stat).to be_a(TopStat)
            global_stat.stats.each do |stat|
              expect(stat).to be_a(Stat)
              expect(stat.metrics).to be_a(Metric)
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

        it '#get_subusers_stats with all params' do
          top_stats = @client.get_subusers_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: :week,
            subusers: @subuser
          )
          expect(top_stats.class).to be(Array)
          top_stats.each do |global_stat|
            expect(global_stat).to be_a(TopStat)
            global_stat.stats.each do |stat|
              expect(stat).to be_a(Stat)
              expect(stat.metrics).to be_a(Metric)
            end
          end
        end

        it '#get_subusers_stats_sums with mandatory params' do
          top_stat = @client.get_subusers_stats_sums(start_date: '2015-01-01')
          expect(top_stat).to be_a(TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(Stat)
            expect(stat.metrics).to be_a(Metric)
          end
        end

        it '#get_subusers_stats_sums with all params' do
          top_stat = @client.get_subusers_stats_sums(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            sort_by_metric: :opens,
            sort_by_direction: :desc,
            limit: 5,
            offset: 0
          )
          expect(top_stat).to be_a(TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(Stat)
            expect(stat.metrics).to be_a(Metric)
          end
        end

        it '#get_subusers_stats_monthly with mandatory params' do
          top_stat = @client.get_subusers_stats_monthly(
            date: '2015-01-01'
          )
          expect(top_stat).to be_a(TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(Stat)
            expect(stat.metrics).to be_a(Metric)
          end
        end

        it '#get_subusers_stats_monthly with all params' do
          begin
            top_stat = @client.get_subusers_stats_monthly(
              date: '2015-01-01',
              subuser: ENV['SUBUSER'],
              sort_by_metric: :opens,
              sort_by_direction: :desc,
              limit: 5,
              offset: 0
            )
            expect(top_stat).to be_a(TopStat)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(Stat)
              expect(stat.metrics).to be_a(Metric)
            end
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end

        it '#get_subuser_stats_monthly with mandatory params' do
          top_stat = @client.get_subuser_stats_monthly(
            subuser_name: ENV['SUBUSER'], date: '2015-01-01'
          )
          expect(top_stat).to be_a(TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(Stat)
            expect(stat.metrics).to be_a(Metric)
          end
        end

        it '#get_subuser_stats_monthly with all params' do
          top_stat = @client.get_subuser_stats_monthly(
            subuser_name: ENV['SUBUSER'], date: '2015-01-01',
            sort_by_metric: :opens,
            sort_by_direction: :desc,
            limit: 5,
            offset: 0
          )
          expect(top_stat).to be_a(TopStat)
          top_stat.stats.each do |stat|
            expect(stat).to be_a(Stat)
            expect(stat.metrics).to be_a(Metric)
          end
        end
      end
    end
  end
end
