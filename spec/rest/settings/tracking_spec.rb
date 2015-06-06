# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Settings::Tracking do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
    end

    context 'without block call' do
      it '#get_tracking_settings' do
        begin
          actual = @client.get_tracking_settings
          expect(
            actual
          ).to be_a(SendGrid4r::REST::Settings::Results)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_click' do
        begin
          actual = @client.get_settings_click
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Tracking::Click
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_click' do
        begin
          # get original settings
          actual = @client.get_settings_click
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_click(params: actual)
          expect(edit.enabled).to eq(false)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_google_analytics' do
        begin
          actual = @client.get_settings_google_analytics
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Tracking::GoogleAnalytics
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_google_analytics' do
        begin
          # get original settings
          actual = @client.get_settings_google_analytics
          # patch the value
          actual.enabled = false
          actual.utm_source = 'a'
          actual.utm_medium = 'b'
          actual.utm_term = 'c'
          actual.utm_content = 'd'
          actual.utm_campaign = 'e'
          edit = @client.patch_settings_google_analytics(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.utm_source).to eq('a')
          expect(edit.utm_medium).to eq('b')
          expect(edit.utm_term).to eq('c')
          expect(edit.utm_content).to eq('d')
          expect(edit.utm_campaign).to eq('e')
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_open' do
        begin
          actual = @client.get_settings_open
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Tracking::Open
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_open' do
        begin
          # get original settings
          actual = @client.get_settings_open
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_open(params: actual)
          expect(edit.enabled).to eq(false)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_subscription' do
        begin
          actual = @client.get_settings_subscription
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Tracking::Subscription
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_subscription' do
        begin
          # get original settings
          actual = @client.get_settings_subscription
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_subscription(params: actual)
          expect(edit.enabled).to eq(false)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_tracking_settings' do
        @client.get_tracking_settings do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings.create_results(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Results)
          resp.result.each do |result|
            expect(result).to be_a(SendGrid4r::REST::Settings::Result)
          end
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_click' do
        @client.get_settings_click do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_click(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Click
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_click' do
        params = @client.get_settings_click
        @client.patch_settings_click(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_click(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Click
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_google_analytics' do
        @client.get_settings_google_analytics do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_google_analytics(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::GoogleAnalytics
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_google_analytics' do
        params = @client.get_settings_google_analytics
        @client.patch_settings_google_analytics(
          params: params
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_google_analytics(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::GoogleAnalytics
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_open' do
        @client.get_settings_open do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_open(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Open
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_open' do
        params = @client.get_settings_open
        @client.patch_settings_open(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_open(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Open
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_subscription' do
        @client.get_settings_subscription do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_subscription(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Subscription
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_subscription' do
        params = @client.get_settings_subscription
        @client.patch_settings_subscription(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Tracking.create_subscription(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Tracking::Subscription
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:click) do
      JSON.parse(
        '{'\
          '"enabled": true'\
        '}'
      )
    end

    it '#get_settings_click' do
      allow(client).to receive(:execute).and_return(click)
      actual = client.get_settings_click
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Click)
    end

    it '#patch_settings_click' do
      allow(client).to receive(:execute).and_return(click)
      actual = client.patch_settings_click(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Click)
    end

    it 'creates click instance' do
      actual = SendGrid4r::REST::Settings::Tracking.create_click(click)
      expect(actual.enabled).to eq(true)
    end

    let(:google_analytics) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"utm_source": "sendgrid.com",'\
          '"utm_medium": "email",'\
          '"utm_term": "",'\
          '"utm_content": "",'\
          '"utm_campaign": "website"'\
        '}'
      )
    end

    it '#get_settings_google_analytics' do
      allow(client).to receive(:execute).and_return(google_analytics)
      actual = client.get_settings_google_analytics
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::Tracking::GoogleAnalytics
      )
    end

    it '#patch_settings_google_analytics' do
      allow(client).to receive(:execute).and_return(google_analytics)
      actual = client.patch_settings_google_analytics(params: nil)
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::Tracking::GoogleAnalytics
      )
    end

    it 'creates google_analytics instance' do
      actual = SendGrid4r::REST::Settings::Tracking.create_google_analytics(
        google_analytics
      )
      expect(actual.enabled).to eq(true)
      expect(actual.utm_source).to eq('sendgrid.com')
      expect(actual.utm_medium).to eq('email')
      expect(actual.utm_term).to eq('')
      expect(actual.utm_content).to eq('')
      expect(actual.utm_campaign).to eq('website')
    end

    let(:open) do
      JSON.parse(
        '{'\
          '"enabled": true'\
        '}'
      )
    end

    it '#get_settings_open' do
      allow(client).to receive(:execute).and_return(open)
      actual = client.get_settings_open
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Open)
    end

    it '#patch_settings_open' do
      allow(client).to receive(:execute).and_return(open)
      actual = client.patch_settings_open(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Open)
    end

    it 'creates open instance' do
      actual = SendGrid4r::REST::Settings::Tracking.create_open(open)
      expect(actual.enabled).to eq(true)
    end

    let(:subscription) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"landing": "landing page html",'\
          '"url": "url",'\
          '"replace": "replacement tag",'\
          '"html_content": "html content",'\
          '"plain_content": "text content"'\
        '}'
      )
    end

    it '#get_settings_subscription' do
      allow(client).to receive(:execute).and_return(subscription)
      actual = client.get_settings_subscription
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Subscription)
    end

    it '#patch_settings_subscription' do
      allow(client).to receive(:execute).and_return(subscription)
      actual = client.patch_settings_subscription(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Tracking::Subscription)
    end

    it 'creates subscription instance' do
      actual = SendGrid4r::REST::Settings::Tracking.create_subscription(
        subscription
      )
      expect(actual.enabled).to eq(true)
      expect(actual.landing).to eq('landing page html')
      expect(actual.url).to eq('url')
      expect(actual.replace).to eq('replacement tag')
      expect(actual.html_content).to eq('html content')
      expect(actual.plain_content).to eq('text content')
    end
  end
end
