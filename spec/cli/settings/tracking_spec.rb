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
          '--api-key', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0
        ]
        Tracking.start(args)
      end

      it '#click get' do
        args = [
          'click', 'get',
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#click enable' do
        args = [
          'click', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#click disable' do
        args = [
          'click', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#ganalytics get' do
        args = [
          'ganalytics', 'get',
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#ganalytics enable' do
        args = [
          'ganalytics', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--utm-source', 'aaa',
          '--utm-medium', 'bbb',
          '--utm-term', 'ccc',
          '--utm-content', 'ddd',
          '--utm-campaign', 'ddd'
        ]
        Tracking.start(args)
      end

      it '#ganalytics disable' do
        args = [
          'ganalytics', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#open get' do
        args = [
          'open', 'get',
          '--api-key', ENV['SILVER_API_KEY'],
        ]
        Tracking.start(args)
      end

      it '#open enable' do
        args = [
          'open', 'enable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#open disable' do
        args = [
          'open', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#subscription get' do
        args = [
          'subscription', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end

      it '#subscription enable' do
        args = [
          'subscription', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--landing', '<p>これまでご購読ありがとうございました。</p>\n\n<p>またのご利用お待ちしております。</p>\n',
          '--url', '',
          '--replace', '',
          '--html-content', '<p>配信停止をご希望の場合、お手数ですが&lt;% こちら&nbsp; %&gt;をクリックしてください。</p>',
          '--plain-content', '配信停止をご希望の場合、お手数ですが次のURLにアクセスしてください。<% %>.'
        ]
        Tracking.start(args)
      end

      it '#subscription disable' do
        args = [
          'subscription', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Tracking.start(args)
      end
    end
  end
end
