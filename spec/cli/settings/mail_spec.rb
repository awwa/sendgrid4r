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
          '--apikey', ENV['SILVER_API_KEY'],
          '--limit', 10,
          '--offset', 0
        ]
        Mail.start(args)
      end

      it '#whitelist get' do
        args = [
          'whitelist', 'get',
          '--apikey', ENV['SILVER_API_KEY'],
        ]
        Mail.start(args)
      end

      it '#whitelist enable' do
        args = [
          'whitelist', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--list', 'abc@abc.com', 'cde@cde.com'
        ]
        Mail.start(args)
      end

      it '#whitelist disable' do
        args = [
          'whitelist', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bcc get' do
        args = [
          'bcc', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bcc enable' do
        args = [
          'bcc', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#bcc disable' do
        args = [
          'bcc', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#bounce_purge get' do
        args = [
          'bounce_purge', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#bounce_purge enable' do
        args = [
          'bounce_purge', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--hard_bounces', 10,
          '--soft_bounces', 20
        ]
        Mail.start(args)
      end

      it '#bounce_purge disable' do
        args = [
          'bounce_purge', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#footer get' do
        args = [
          'footer', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#footer enable' do
        args = [
          'footer', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--html_content', 'This is a footer.',
          '--plain_content', 'This is a footer.'
        ]
        Mail.start(args)
      end

      it '#footer disable' do
        args = [
          'footer', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_bounce get' do
        args = [
          'forward_bounce', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_bounce enable' do
        args = [
          'forward_bounce', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_bounce disable' do
        args = [
          'forward_bounce', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_spam get' do
        args = [
          'forward_spam', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#forward_spam enable' do
        args = [
          'forward_spam', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#forward_spam disable' do
        args = [
          'forward_spam', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--email', ENV['MAIL']
        ]
        Mail.start(args)
      end

      it '#spam_check get' do
        args = [
          'spam_check', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#spam_check enable' do
        args = [
          'spam_check', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--max_score', 5
        ]
        Mail.start(args)
      end

      it '#spam_check disable' do
        args = [
          'spam_check', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--url', 'http://test.test.test',
          '--max_score', 5
        ]
        Mail.start(args)
      end

      it '#template get' do
        args = [
          'template', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#template enable' do
        args = [
          'template', 'enable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--html_content', '<% body %>'
        ]
        Mail.start(args)
      end

      it '#template disable' do
        args = [
          'template', 'disable',
          '--apikey', ENV['SILVER_API_KEY'],
          '--html_content', '<% body %>'
        ]
        Mail.start(args)
      end

      it '#plain_content get' do
        args = [
          'plain_content', 'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#plain_content enable' do
        args = [
          'plain_content', 'enable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end

      it '#plain_content disable' do
        args = [
          'plain_content', 'disable',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Mail.start(args)
      end
    end
  end
end
