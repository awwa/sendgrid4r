# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Stats::Parse do
  describe 'integration test' do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    end

    context 'without block call' do
      it '#get_parse_stats with mandatory params' do
        actual = @client.get_parse_stats(start_date: '2015-01-01')
        expect(actual.class).to be(Array)
        expect(actual.length > 0).to be(true)
        actual.each do |global_stat|
          expect(global_stat.class).to be(SendGrid4r::REST::Stats::TopStat)
          stats = global_stat.stats
          expect(stats.length).to eq(1)
          stats.each do |stat|
            expect(stat.class).to be(SendGrid4r::REST::Stats::Stat)
            expect(stat.metrics.class).to be(SendGrid4r::REST::Stats::Metric)
            expect(stat.metrics.received.nil?).to be(false)
            expect(stat.metrics.blocks.nil?).to be(true)
          end
        end
      end

      it '#get_parse_stats with all params' do
        actual = @client.get_parse_stats(
          start_date: '2015-01-01',
          end_date: '2015-01-02',
          aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
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
  end
end
