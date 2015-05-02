# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Stats::Advanced do
  describe 'integration test' do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        username: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'])
    end

    context 'without block call' do
      it '#get_geo_stats with mandatory params' do
        begin
          top_stats = @client.get_geo_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
              expect(stat.metrics.clicks.nil?).to be(false)
              expect(stat.metrics.opens.nil?).to be(false)
              expect(stat.metrics.unique_clicks.nil?).to be(false)
              expect(stat.metrics.unique_opens.nil?).to be(false)
              expect(stat.name).to be_a(String)
              expect(stat.type).to eq('country')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_geo_stats with all params' do
        begin
          top_stats = @client.get_geo_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
            country: 'US'
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_devices_stats with mandatory params' do
        begin
          top_stats = @client.get_devices_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
              expect(stat.name).to be_a(String)
              expect(stat.type).to eq('device')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_devices_stats with all params' do
        begin
          top_stats = @client.get_devices_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_clients_stats with mandatory params' do
        begin
          top_stats = @client.get_clients_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
              expect(stat.name).to be_a(String)
              expect(stat.type).to eq('client')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_clients_stats with all params' do
        begin
          top_stats = @client.get_clients_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_clients_type_stats with mandatory params' do
        begin
          top_stats = @client.get_clients_type_stats(
            start_date: '2015-01-01', client_type: 'webmail'
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
              expect(stat.name).to be_a(String)
              expect(stat.type).to eq('client')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_clients_stats with all params' do
        begin
          top_stats = @client.get_clients_type_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
            client_type: 'webmail'
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_mailbox_providers_stats with mandatory params' do
        begin
          top_stats =
            @client.get_mailbox_providers_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
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
              expect(stat.name).to be_a(String)
              expect(stat.type).to eq('mailbox_provider')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_mailbox_providers_stats with all params' do
        begin
          top_stats = @client.get_mailbox_providers_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
            esps: 'sss'
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_browsers_stats with mandatory params' do
        begin
          top_stats = @client.get_browsers_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
              expect(stat.name).to eq(nil)
              expect(stat.type).to eq('browser')
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_browsers_stats with all params' do
        begin
          top_stats = @client.get_browsers_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
            browsers: 'chrome'
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
            expect(top_stat.date).to be_a(String)
            expect(top_stat.stats).to be_a(Array)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
              expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_geo_stats with all params' do
        @client.get_geo_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          country: 'US'
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

      it '#get_devices_stats with all params' do
        @client.get_devices_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
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

      it '#get_clients_stats with all params' do
        @client.get_clients_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
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

      it '#get_clients_type_stats with all params' do
        @client.get_clients_type_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          client_type: 'webmail'
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

      it '#get_mailbox_providers_stats with all params' do
        @client.get_mailbox_providers_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          esps: 'sss'
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

      it '#get_browsers_stats with all params' do
        @client.get_browsers_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
          browsers: 'chrome'
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
    end
  end
end
