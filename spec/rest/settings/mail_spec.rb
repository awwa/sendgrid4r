# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Settings::Mail do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
    end

    context 'without block call' do
      it '#get_mail_settings' do
        begin
          actual = @client.get_mail_settings
          expect(
            actual
          ).to be_a(SendGrid4r::REST::Settings::Results)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_address_whitelist' do
        begin
          actual = @client.get_settings_address_whitelist
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Mail::AddressWhitelist
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_address_whitelist' do
        begin
          # get original settings
          actual = @client.get_settings_address_whitelist
          # patch the value
          actual.enabled = false
          actual.list = ['test@white.list.com', 'white.list.com']
          edit = @client.patch_settings_address_whitelist(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.list[0]).to eq('test@white.list.com')
          expect(edit.list[1]).to eq('white.list.com')
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_bcc' do
        begin
          actual = @client.get_settings_bcc
          expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Bcc)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_bcc' do
        begin
          # get original settings
          actual = @client.get_settings_bcc
          # patch the value
          actual.enabled = false
          actual.email = 'test@bcc.com'
          edit = @client.patch_settings_bcc(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq('test@bcc.com')
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_bounce_purge' do
        begin
          actual = @client.get_settings_bounce_purge
          expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::BouncePurge)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_bounce_purge' do
        begin
          # get original settings
          actual = @client.get_settings_bounce_purge
          # patch the value
          actual.enabled = false
          # actual.hard_bounces = 123
          # actual.soft_bounces = 321
          edit = @client.patch_settings_bounce_purge(params: actual)
          expect(edit.enabled).to eq(false)
          # expect(actual.hard_bounces).to eq(123)
          # expect(actual.soft_bounces).to eq(321)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_event_notification' do
        begin
          actual = @client.get_settings_event_notification
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Mail::EventNotification
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_event_notification' do
        begin
          # get original settings
          actual = @client.get_settings_event_notification
          # patch the value
          actual.enabled = false
          actual.url = 'http://www.google.com/?=test@test.com'
          actual.group_resubscribe = true
          actual.delivered = true
          actual.group_unsubscribe = true
          actual.spam_report = true
          actual.bounce = true
          actual.deferred = true
          actual.unsubscribe = true
          actual.processed = true
          actual.open = true
          actual.click = true
          actual.dropped = true
          edit = @client.patch_settings_event_notification(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.url).to eq('http://www.google.com/?=test@test.com')
          expect(edit.group_resubscribe).to eq(true)
          expect(edit.delivered).to eq(true)
          expect(edit.group_unsubscribe).to eq(true)
          expect(edit.spam_report).to eq(true)
          expect(edit.bounce).to eq(true)
          expect(edit.deferred).to eq(true)
          expect(edit.unsubscribe).to eq(true)
          expect(edit.processed).to eq(true)
          expect(edit.open).to eq(true)
          expect(edit.click).to eq(true)
          expect(edit.dropped).to eq(true)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#test_settings_event_notification' do
        begin
          @client.test_settings_event_notification(url: ENV['EVENT_URL'])
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_footer' do
        begin
          actual = @client.get_settings_footer
          expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Footer)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_footer' do
        begin
          # get original settings
          actual = @client.get_settings_footer
          # patch the value
          actual.enabled = false
          actual.html_content = 'abc...'
          actual.plain_content = 'xyz...'
          edit = @client.patch_settings_footer(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.html_content).to eq('abc...')
          expect(edit.plain_content).to eq('xyz...')
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_forward_bounce' do
        begin
          actual = @client.get_settings_forward_bounce
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Mail::ForwardBounce
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_forward_bounce' do
        begin
          # get original settings
          actual = @client.get_settings_forward_bounce
          # patch the value
          actual.enabled = false
          actual.email = ENV['MAIL']
          edit = @client.patch_settings_forward_bounce(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq(ENV['MAIL'])
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_forward_spam' do
        begin
          actual = @client.get_settings_forward_spam
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Mail::ForwardSpam
          )
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_forward_spam' do
        begin
          # get original settings
          actual = @client.get_settings_forward_spam
          # patch the value
          actual.enabled = false
          actual.email = ENV['MAIL']
          edit = @client.patch_settings_forward_spam(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq(ENV['MAIL'])
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_template' do
        begin
          actual = @client.get_settings_template
          expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Template)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_template' do
        begin
          # get original settings
          actual = @client.get_settings_template
          # patch the value
          actual.enabled = false
          actual.html_content = '...<% body %>'
          edit = @client.patch_settings_template(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.html_content).to eq('...<% body %>')
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_plain_content' do
        begin
          actual = @client.get_settings_plain_content
          expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::PlainContent)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_plain_content' do
        begin
          # get original settings
          actual = @client.get_settings_plain_content
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_plain_content(params: actual)
          expect(edit.enabled).to eq(false)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_mail_settings' do
        @client.get_mail_settings do |resp, req, res|
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

      it '#get_settings_address_whitelist' do
        @client.get_settings_address_whitelist do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_address_whitelist(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Mail::AddressWhitelist
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_address_whitelist' do
        params = @client.get_settings_address_whitelist
        @client.patch_settings_address_whitelist(
          params: params
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_address_whitelist(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Mail::AddressWhitelist
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_bcc' do
        @client.get_settings_bcc do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_bcc(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Bcc)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_bcc' do
        params = @client.get_settings_bcc
        @client.patch_settings_bcc(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_bcc(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Bcc)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_bounce_purge' do
        @client.get_settings_bounce_purge do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_bounce_purge(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::BouncePurge)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_bounce_purge' do
        params = @client.get_settings_bounce_purge
        @client.patch_settings_bounce_purge(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_bounce_purge(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::BouncePurge)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_event_notification' do
        @client.get_settings_event_notification do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_event_notification(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Mail::EventNotification
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_event_notification' do
        params = @client.get_settings_event_notification
        @client.patch_settings_event_notification(
          params: params
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_event_notification(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::Mail::EventNotification
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#test_settings_event_notification' do
        begin
          @client.test_settings_event_notification(
            url: ENV['EVENT_URL']
          ) do |resp, req, res|
            expect(resp).to eq('')
            expect(req).to be_a(RestClient::Request)
            expect(res).to be_a(Net::HTTPNoContent)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_footer' do
        @client.get_settings_footer do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_footer(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Footer)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_footer' do
        params = @client.get_settings_footer
        @client.patch_settings_footer(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_footer(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Footer)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_forward_bounce' do
        @client.get_settings_forward_bounce do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_forward_bounce(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::ForwardBounce)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_forward_bounce' do
        params = @client.get_settings_forward_bounce
        @client.patch_settings_forward_bounce(
          params: params
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_forward_bounce(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::ForwardBounce)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_forward_spam' do
        @client.get_settings_forward_spam do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_forward_spam(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::ForwardSpam)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_forward_spam' do
        params = @client.get_settings_forward_spam
        @client.patch_settings_forward_spam(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_forward_spam(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::ForwardSpam)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_template' do
        @client.get_settings_template do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_template(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Template)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_template' do
        params = @client.get_settings_template
        @client.patch_settings_template(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_template(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::Template)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_settings_plain_content' do
        @client.get_settings_template do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_plain_content(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::PlainContent)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_settings_plain_content' do
        params = @client.get_settings_plain_content
        @client.patch_settings_plain_content(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::Mail.create_plain_content(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Settings::Mail::PlainContent)
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

    let(:address_whitelist) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"list": ['\
            '"email1@example.com",'\
            '"example.com"'\
          ']'\
        '}'
      )
    end

    it '#get_settings_address_whitelist' do
      allow(client).to receive(:execute).and_return(address_whitelist)
      actual = client.get_settings_address_whitelist
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::AddressWhitelist)
    end

    it '#patch_settings_address_whitelist' do
      allow(client).to receive(:execute).and_return(address_whitelist)
      actual = client.patch_settings_address_whitelist(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::AddressWhitelist)
    end

    it 'creates address_whitelist instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_address_whitelist(
        address_whitelist
      )
      expect(actual.enabled).to eq(true)
      expect(actual.list).to be_a(Array)
      actual.list.each do |address|
        expect(address).to be_a(String)
      end
    end

    let(:bcc) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"email": "email@example.com"'\
        '}'
      )
    end

    it '#get_settings_bcc' do
      allow(client).to receive(:execute).and_return(bcc)
      actual = client.get_settings_bcc
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Bcc)
    end

    it '#patch_settings_bcc' do
      allow(client).to receive(:execute).and_return(bcc)
      actual = client.patch_settings_bcc(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Bcc)
    end

    it 'creates bcc instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_bcc(bcc)
      expect(actual.enabled).to eq(true)
      expect(actual.email).to eq('email@example.com')
    end

    let(:bounce_purge) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"hard_bounces": 1,'\
          '"soft_bounces": 1'\
        '}'
      )
    end

    it '#get_settings_bounce_purge' do
      allow(client).to receive(:execute).and_return(bounce_purge)
      actual = client.get_settings_bounce_purge
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::BouncePurge)
    end

    it '#patch_settings_bounce_purge' do
      allow(client).to receive(:execute).and_return(bounce_purge)
      actual = client.patch_settings_bounce_purge(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::BouncePurge)
    end

    it 'creates bounce_purge instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_bounce_purge(
        bounce_purge
      )
      expect(actual.enabled).to eq(true)
      expect(actual.hard_bounces).to eq(1)
      expect(actual.soft_bounces).to eq(1)
    end

    let(:event_notification) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"url": "url",'\
          '"group_resubscribe": true,'\
          '"delivered": true,'\
          '"group_unsubscribe": true,'\
          '"spam_report": true,'\
          '"bounce": true,'\
          '"deferred": true,'\
          '"unsubscribe": true,'\
          '"processed": true,'\
          '"open": true,'\
          '"click": true,'\
          '"dropped": true'\
        '}'
      )
    end

    it '#get_settings_event_notification' do
      allow(client).to receive(:execute).and_return(event_notification)
      actual = client.get_settings_event_notification
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::Mail::EventNotification
      )
    end

    it '#patch_settings_event_notification' do
      allow(client).to receive(:execute).and_return(event_notification)
      actual = client.patch_settings_event_notification(params: nil)
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::Mail::EventNotification
      )
    end

    it 'creates event_notification instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_event_notification(
        event_notification
      )
      expect(actual.enabled).to eq(true)
      expect(actual.url).to eq('url')
      expect(actual.group_resubscribe).to eq(true)
      expect(actual.delivered).to eq(true)
      expect(actual.group_unsubscribe).to eq(true)
      expect(actual.spam_report).to eq(true)
      expect(actual.bounce).to eq(true)
      expect(actual.deferred).to eq(true)
      expect(actual.unsubscribe).to eq(true)
      expect(actual.processed).to eq(true)
      expect(actual.open).to eq(true)
      expect(actual.click).to eq(true)
      expect(actual.dropped).to eq(true)
    end

    let(:footer) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"html_content": "abc...",'\
          '"plain_content": "xyz..."'\
        '}'
      )
    end

    it '#get_settings_footer' do
      allow(client).to receive(:execute).and_return(footer)
      actual = client.get_settings_footer
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Footer)
    end

    it '#patch_settings_footer' do
      allow(client).to receive(:execute).and_return(footer)
      actual = client.patch_settings_footer(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Footer)
    end

    it 'creates footer instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_footer(footer)
      expect(actual.enabled).to eq(true)
      expect(actual.html_content).to eq('abc...')
      expect(actual.plain_content).to eq('xyz...')
    end

    let(:forward_bounce) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"email": "email address"'\
        '}'
      )
    end

    it '#get_settings_forward_bounce' do
      allow(client).to receive(:execute).and_return(forward_bounce)
      actual = client.get_settings_forward_bounce
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::ForwardBounce)
    end

    it '#patch_settings_forward_bounce' do
      allow(client).to receive(:execute).and_return(forward_bounce)
      actual = client.patch_settings_forward_bounce(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::ForwardBounce)
    end

    it 'creates forward_bounce instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_forward_bounce(
        forward_bounce
      )
      expect(actual.enabled).to eq(true)
      expect(actual.email).to eq('email address')
    end

    let(:forward_spam) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"email": "email address"'\
        '}'
      )
    end

    it '#get_settings_forward_spam' do
      allow(client).to receive(:execute).and_return(forward_spam)
      actual = client.get_settings_forward_spam
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::ForwardSpam)
    end

    it '#patch_settings_forward_spam' do
      allow(client).to receive(:execute).and_return(forward_spam)
      actual = client.patch_settings_forward_spam(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::ForwardSpam)
    end

    it 'creates forward_spam instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_forward_spam(
        forward_spam
      )
      expect(actual.enabled).to eq(true)
      expect(actual.email).to eq('email address')
    end

    let(:template) do
      JSON.parse(
        '{'\
          '"enabled": true,'\
          '"html_content": "..."'\
        '}'
      )
    end

    it '#get_settings_template' do
      allow(client).to receive(:execute).and_return(template)
      actual = client.get_settings_template
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Template)
    end

    it '#patch_settings_template' do
      allow(client).to receive(:execute).and_return(template)
      actual = client.patch_settings_template(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::Template)
    end

    it 'creates template instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_template(template)
      expect(actual.enabled).to eq(true)
      expect(actual.html_content).to eq('...')
    end

    let(:plain_content) do
      JSON.parse(
        '{'\
          '"enabled": true'\
        '}'
      )
    end

    it '#get_settings_plain_content' do
      allow(client).to receive(:execute).and_return(plain_content)
      actual = client.get_settings_plain_content
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::PlainContent)
    end

    it '#patch_settings_plain_content' do
      allow(client).to receive(:execute).and_return(plain_content)
      actual = client.patch_settings_plain_content(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Mail::PlainContent)
    end

    it 'creates plain_content instance' do
      actual = SendGrid4r::REST::Settings::Mail.create_plain_content(
        plain_content
      )
      expect(actual.enabled).to eq(true)
    end
  end
end
