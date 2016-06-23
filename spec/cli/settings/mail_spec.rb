# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Settings
  describe Mail do
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
        Mail.start(args)
      end

      it '#whitelist get' do
        args = [
          'whitelist', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#whitelist enable' do
        args = [
          'whitelist', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--list', 'abc@abc.com', 'cde@cde.com'
        ]
        Mail.start(args)
      end

      it '#whitelist disable' do
        args = [
          'whitelist', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bcc get' do
        args = [
          'bcc', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bcc enable' do
        args = [
          'bcc', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#bcc disable' do
        args = [
          'bcc', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#bounce_purge get' do
        args = [
          'bounce_purge', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bounce_purge enable' do
        args = [
          'bounce_purge', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--hard-bounces', 10,
          '--soft-bounces', 20
        ]
        Mail.start(args)
      end

      it '#bounce_purge disable' do
        args = [
          'bounce_purge', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#footer get' do
        args = [
          'footer', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#footer enable' do
        args = [
          'footer', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--html-content', 'This is a footer.',
          '--plain-content', 'This is a footer.'
        ]
        Mail.start(args)
      end

      it '#footer disable' do
        args = [
          'footer', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_bounce get' do
        args = [
          'forward_bounce', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_bounce enable' do
        args = [
          'forward_bounce', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_bounce disable' do
        args = [
          'forward_bounce', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_spam get' do
        args = [
          'forward_spam', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_spam enable' do
        args = [
          'forward_spam', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_spam disable' do
        args = [
          'forward_spam', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#spam_check get' do
        args = [
          'spam_check', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#spam_check enable' do
        args = [
          'spam_check', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--max-score', 5
        ]
        Mail.start(args)
      end

      it '#spam_check disable' do
        args = [
          'spam_check', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--max-score', 5
        ]
        Mail.start(args)
      end

      it '#template get' do
        args = [
          'template', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#template enable' do
        args = [
          'template', 'enable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--html-content', '<% body %>'
        ]
        Mail.start(args)
      end

      it '#template disable' do
        args = [
          'template', 'disable',
          '--api-key', ENV['SILVER_API_KEY'],
          '--html-content', '<% body %>'
        ]
        Mail.start(args)
      end

      it '#plain_content get' do
        args = [
          'plain_content', 'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#plain_content enable' do
        args = [
          'plain_content', 'enable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#plain_content disable' do
        args = [
          'plain_content', 'disable',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end
    end
  end
end
