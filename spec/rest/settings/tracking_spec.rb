# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Settings
  describe Tracking do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      end

      context 'without block call' do
        it '#get_tracking_settings' do
          actual = @client.get_tracking_settings
          expect(
            actual
          ).to be_a(Results)
        end

        it '#get_settings_click' do
          actual = @client.get_settings_click
          expect(actual).to be_a(Tracking::Click)
        end

        it '#patch_settings_click' do
          # get original settings
          actual = @client.get_settings_click
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_click(params: actual)
          expect(edit.enabled).to eq(false)
        end

        it '#get_settings_google_analytics' do
          actual = @client.get_settings_google_analytics
          expect(actual).to be_a(Tracking::GoogleAnalytics)
        end

        it '#patch_settings_google_analytics' do
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
        end

        it '#get_settings_open' do
          actual = @client.get_settings_open
          expect(actual).to be_a(Tracking::Open)
        end

        it '#patch_settings_open' do
          # get original settings
          actual = @client.get_settings_open
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_open(params: actual)
          expect(edit.enabled).to eq(false)
        end

        it '#get_settings_subscription' do
          actual = @client.get_settings_subscription
          expect(actual).to be_a(Tracking::Subscription)
        end

        it '#patch_settings_subscription' do
          # get original settings
          actual = @client.get_settings_subscription
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_subscription(params: actual)
          expect(edit.enabled).to eq(false)
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
        expect(actual).to be_a(Tracking::Click)
      end

      it '#patch_settings_click' do
        allow(client).to receive(:execute).and_return(click)
        actual = client.patch_settings_click(params: nil)
        expect(actual).to be_a(Tracking::Click)
      end

      it 'creates click instance' do
        actual = Tracking.create_click(click)
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
        expect(actual).to be_a(Tracking::GoogleAnalytics)
      end

      it '#patch_settings_google_analytics' do
        allow(client).to receive(:execute).and_return(google_analytics)
        actual = client.patch_settings_google_analytics(params: nil)
        expect(actual).to be_a(Tracking::GoogleAnalytics)
      end

      it 'creates google_analytics instance' do
        actual = Tracking.create_google_analytics(google_analytics)
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
        expect(actual).to be_a(Tracking::Open)
      end

      it '#patch_settings_open' do
        allow(client).to receive(:execute).and_return(open)
        actual = client.patch_settings_open(params: nil)
        expect(actual).to be_a(Tracking::Open)
      end

      it 'creates open instance' do
        actual = Tracking.create_open(open)
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
        expect(actual).to be_a(Tracking::Subscription)
      end

      it '#patch_settings_subscription' do
        allow(client).to receive(:execute).and_return(subscription)
        actual = client.patch_settings_subscription(params: nil)
        expect(actual).to be_a(Tracking::Subscription)
      end

      it 'creates subscription instance' do
        actual = Tracking.create_subscription(subscription)
        expect(actual.enabled).to eq(true)
        expect(actual.landing).to eq('landing page html')
        expect(actual.url).to eq('url')
        expect(actual.replace).to eq('replacement tag')
        expect(actual.html_content).to eq('html content')
        expect(actual.plain_content).to eq('text content')
      end
    end
  end
end
