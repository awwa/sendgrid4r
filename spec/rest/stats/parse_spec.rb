# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Stats
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#get_parse_stats with mandatory params' do
          top_stats = @client.get_parse_stats(start_date: '2015-01-01')
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
            expect(top_stat).to be_a(TopStat)
            top_stat.stats.each do |stat|
              expect(stat).to be_a(Stat)
              expect(stat.metrics.class).to be(Metric)
              expect(stat.metrics.received.nil?).to be(false)
              expect(stat.metrics.blocks.nil?).to be(true)
            end
          end
        end

        it '#get_parse_stats with all params' do
          top_stats = @client.get_parse_stats(
            start_date: '2015-01-01',
            end_date: '2015-01-02',
            aggregated_by: :week
          )
          expect(top_stats).to be_a(Array)
          top_stats.each do |top_stat|
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
end
