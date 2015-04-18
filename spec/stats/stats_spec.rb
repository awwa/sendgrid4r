# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Stats do
  before do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
  end

  context 'unit test' do
    it 'creates top_stats instance' do
      json =
        '['\
          '{'\
            '"date": "2015-01-01",'\
            '"stats": ['\
              '{'\
                '"metrics": {'\
                  '"blocks": 0,'\
                  '"bounce_drops": 0,'\
                  '"bounces": 0,'\
                  '"clicks": 0,'\
                  '"deferred": 0,'\
                  '"delivered": 0,'\
                  '"invalid_emails": 0,'\
                  '"opens": 0,'\
                  '"processed": 0,'\
                  '"requests": 0,'\
                  '"spam_report_drops": 0,'\
                  '"spam_reports": 0,'\
                  '"unique_clicks": 0,'\
                  '"unique_opens": 0,'\
                  '"unsubscribe_drops": 0,'\
                  '"unsubscribes": 0'\
                '},'\
                '"name": "cat1",'\
                '"type": "category"'\
              '},'\
              '{'\
                '"metrics": {'\
                  '"blocks": 0,'\
                  '"bounce_drops": 0,'\
                  '"bounces": 0,'\
                  '"clicks": 0,'\
                  '"deferred": 0,'\
                  '"delivered": 0,'\
                  '"invalid_emails": 0,'\
                  '"opens": 0,'\
                  '"processed": 0,'\
                  '"requests": 0,'\
                  '"spam_report_drops": 0,'\
                  '"spam_reports": 0,'\
                  '"unique_clicks": 0,'\
                  '"unique_opens": 0,'\
                  '"unsubscribe_drops": 0,'\
                  '"unsubscribes": 0'\
                '},'\
                '"name": "cat2",'\
                '"type": "category"'\
              '}'\
            ']'\
          '},'\
          '{'\
            '"date": "2015-01-02",'\
            '"stats": ['\
              '{'\
                '"metrics": {'\
                  '"blocks": 10,'\
                  '"bounce_drops": 0,'\
                  '"bounces": 0,'\
                  '"clicks": 0,'\
                  '"deferred": 0,'\
                  '"delivered": 0,'\
                  '"invalid_emails": 0,'\
                  '"opens": 0,'\
                  '"processed": 0,'\
                  '"requests": 10,'\
                  '"spam_report_drops": 0,'\
                  '"spam_reports": 0,'\
                  '"unique_clicks": 0,'\
                  '"unique_opens": 0,'\
                  '"unsubscribe_drops": 0,'\
                  '"unsubscribes": 0'\
                '},'\
                '"name": "cat1",'\
                '"type": "category"'\
              '},'\
              '{'\
                '"metrics": {'\
                  '"blocks": 0,'\
                  '"bounce_drops": 0,'\
                  '"bounces": 0,'\
                  '"clicks": 6,'\
                  '"deferred": 0,'\
                  '"delivered": 5,'\
                  '"invalid_emails": 0,'\
                  '"opens": 6,'\
                  '"processed": 0,'\
                  '"requests": 5,'\
                  '"spam_report_drops": 0,'\
                  '"spam_reports": 0,'\
                  '"unique_clicks": 5,'\
                  '"unique_opens": 5,'\
                  '"unsubscribe_drops": 0,'\
                  '"unsubscribes": 6'\
                '},'\
                '"name": "cat2",'\
                '"type": "category"'\
              '}'\
            ']'\
          '}'\
        ']'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Stats.create_top_stats(hash)
      expect(actual).to be_a(Array)
      actual.each do |top_stat|
        expect(top_stat).to be_a(SendGrid4r::REST::Stats::TopStat)
        top_stat.stats.each do |stat|
          expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
          expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
        end
      end
    end

    it 'creates top_stat instance' do
      json =
        '{'\
          '"date": "2015-01-01",'\
          '"stats": ['\
            '{'\
              '"metrics": {'\
                '"blocks": 0,'\
                '"bounce_drops": 0,'\
                '"bounces": 0,'\
                '"clicks": 20,'\
                '"deferred": 0,'\
                '"delivered": 20,'\
                '"invalid_emails": 0,'\
                '"opens": 20,'\
                '"processed": 0,'\
                '"requests": 20,'\
                '"spam_report_drops": 0,'\
                '"spam_reports": 0,'\
                '"unique_clicks": 20,'\
                '"unique_opens": 20,'\
                '"unsubscribe_drops": 0,'\
                '"unsubscribes": 20'\
              '},'\
              '"name": "cat1",'\
              '"type": "category"'\
            '},'\
            '{'\
              '"metrics": {'\
                '"blocks": 1,'\
                '"bounce_drops": 0,'\
                '"bounces": 0,'\
                '"clicks": 19,'\
                '"deferred": 0,'\
                '"delivered": 19,'\
                '"invalid_emails": 0,'\
                '"opens": 19,'\
                '"processed": 0,'\
                '"requests": 20,'\
                '"spam_report_drops": 0,'\
                '"spam_reports": 0,'\
                '"unique_clicks": 19,'\
                '"unique_opens": 19,'\
                '"unsubscribe_drops": 0,'\
                '"unsubscribes": 19'\
              '},'\
              '"name": "cat2",'\
              '"type": "category"'\
            '},'\
            '{'\
              '"metrics": {'\
                '"blocks": 0,'\
                '"bounce_drops": 0,'\
                '"bounces": 0,'\
                '"deferred": 0,'\
                '"clicks": 5,'\
                '"delivered": 5,'\
                '"invalid_emails": 0,'\
                '"opens": 5,'\
                '"processed": 0,'\
                '"requests": 5,'\
                '"spam_report_drops": 0,'\
                '"spam_reports": 0,'\
                '"unique_clicks": 5,'\
                '"unique_opens": 5,'\
                '"unsubscribe_drops": 0,'\
                '"unsubscribes": 5'\
              '},'\
              '"name": "cat3",'\
              '"type": "category"'\
            '},'\
            '{'\
              '"metrics": {'\
                '"blocks": 0,'\
                '"bounce_drops": 0,'\
                '"bounces": 0,'\
                '"clicks": 6,'\
                '"deferred": 0,'\
                '"delivered": 5,'\
                '"invalid_emails": 0,'\
                '"opens": 6,'\
                '"processed": 0,'\
                '"requests": 5,'\
                '"spam_report_drops": 0,'\
                '"spam_reports": 0,'\
                '"unique_clicks": 5,'\
                '"unique_opens": 5,'\
                '"unsubscribe_drops": 0,'\
                '"unsubscribes": 6'\
              '},'\
              '"name": "cat4",'\
              '"type": "category"'\
            '},'\
            '{'\
              '"metrics": {'\
                '"blocks": 10,'\
                '"bounce_drops": 0,'\
                '"bounces": 0,'\
                '"clicks": 0,'\
                '"deferred": 0,'\
                '"delivered": 0,'\
                '"invalid_emails": 0,'\
                '"opens": 0,'\
                '"processed": 0,'\
                '"requests": 10,'\
                '"spam_report_drops": 0,'\
                '"spam_reports": 0,'\
                '"unique_clicks": 0,'\
                '"unique_opens": 0,'\
                '"unsubscribe_drops": 0,'\
                '"unsubscribes": 0'\
              '},'\
              '"name": "cat5",'\
              '"type": "category"'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Stats.create_top_stat(hash)
      expect(actual).to be_a(SendGrid4r::REST::Stats::TopStat)
      actual.stats.each do |stat|
        expect(stat).to be_a(SendGrid4r::REST::Stats::Stat)
        expect(stat.metrics).to be_a(SendGrid4r::REST::Stats::Metric)
      end
    end
  end
end
