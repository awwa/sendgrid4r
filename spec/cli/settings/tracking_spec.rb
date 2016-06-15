# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Settings
  describe Tracking do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0
        ]
        Tracking.start(args)
      end

      it '#click get' do
        args = [
          'click', 'get',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#click enable' do
        args = [
          'click', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#click disable' do
        args = [
          'click', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#ganalytics get' do
        args = [
          'ganalytics', 'get',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#ganalytics enable' do
        args = [
          'ganalytics', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--utm_source', 'aaa',
          '--utm_medium', 'bbb',
          '--utm_term', 'ccc',
          '--utm_content', 'ddd',
          '--utm_campaign', 'ddd'
        ]
        Tracking.start(args)
      end

      it '#ganalytics disable' do
        args = [
          'ganalytics', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#open get' do
        args = [
          'open', 'get',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#open enable' do
        args = [
          'open', 'enable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#open disable' do
        args = [
          'open', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#subscription get' do
        args = [
          'subscription', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#subscription enable' do
        args = [
          'subscription', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--landing', '<p>これまでご購読ありがとうございました。</p>\n\n<p>またのご利用お待ちしております。</p>\n',
          '--url', '',
          '--replace', '',
          '--html_content', '<p>配信停止をご希望の場合、お手数ですが&lt;% こちら&nbsp; %&gt;をクリックしてください。</p>',
          '--plain_content', '配信停止をご希望の場合、お手数ですが次のURLにアクセスしてください。<% %>.'
        ]
        Tracking.start(args)
      end

      it '#subscription disable' do
        args = [
          'subscription', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

    end
  end
end
