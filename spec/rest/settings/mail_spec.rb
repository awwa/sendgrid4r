# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Settings
  describe Mail do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      end

      context 'without block call' do
        it '#get_mail_settings' do
          actual = @client.get_mail_settings
          expect(actual).to be_a(Results)
        end

        it '#get_settings_address_whitelist' do
          actual = @client.get_settings_address_whitelist
          expect(actual).to be_a(Mail::AddressWhitelist)
        end

        it '#patch_settings_address_whitelist' do
          # get original settings
          actual = @client.get_settings_address_whitelist
          # patch the value
          actual.enabled = false
          actual.list = ['test@white.list.com', 'white.list.com']
          edit = @client.patch_settings_address_whitelist(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.list[0]).to eq('test@white.list.com')
          expect(edit.list[1]).to eq('white.list.com')
        end

        it '#get_settings_bcc' do
          actual = @client.get_settings_bcc
          expect(actual).to be_a(Mail::Bcc)
        end

        it '#patch_settings_bcc' do
          # get original settings
          actual = @client.get_settings_bcc
          # patch the value
          actual.enabled = false
          actual.email = 'test@bcc.com'
          edit = @client.patch_settings_bcc(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq('test@bcc.com')
        end

        it '#get_settings_bounce_purge' do
          actual = @client.get_settings_bounce_purge
          expect(actual).to be_a(Mail::BouncePurge)
        end

        it '#patch_settings_bounce_purge' do
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
        end

        it '#get_settings_footer' do
          actual = @client.get_settings_footer
          expect(actual).to be_a(Mail::Footer)
        end

        it '#patch_settings_footer' do
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
        end

        it '#get_settings_forward_bounce' do
          actual = @client.get_settings_forward_bounce
          expect(actual).to be_a(Mail::ForwardBounce)
        end

        it '#patch_settings_forward_bounce' do
          # get original settings
          actual = @client.get_settings_forward_bounce
          # patch the value
          actual.enabled = false
          actual.email = ENV['MAIL']
          edit = @client.patch_settings_forward_bounce(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq(ENV['MAIL'])
        end

        it '#get_settings_forward_spam' do
          actual = @client.get_settings_forward_spam
          expect(actual).to be_a(Mail::ForwardSpam)
        end

        it '#patch_settings_forward_spam' do
          # get original settings
          actual = @client.get_settings_forward_spam
          # patch the value
          actual.enabled = false
          actual.email = ENV['MAIL']
          edit = @client.patch_settings_forward_spam(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.email).to eq(ENV['MAIL'])
        end

        it '#get_settings_spam_check' do
          actual = @client.get_settings_spam_check
          expect(actual).to be_a(Mail::SpamCheck)
        end

        it '#patch_settings_spam_check' do
          # get original settings
          actual = @client.get_settings_spam_check
          # patch the value
          actual.enabled = false
          actual.url = 'http://test.test.test'
          actual.max_score = 4
          edit = @client.patch_settings_spam_check(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.url).to eq('http://test.test.test')
          expect(edit.max_score).to eq(4)
        end

        it '#get_settings_template' do
          actual = @client.get_settings_template
          expect(actual).to be_a(Mail::Template)
        end

        it '#patch_settings_template' do
          # get original settings
          actual = @client.get_settings_template
          # patch the value
          actual.enabled = false
          actual.html_content = '...<% body %>'
          edit = @client.patch_settings_template(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.html_content).to eq('...<% body %>')
        end

        it '#get_settings_plain_content' do
          actual = @client.get_settings_plain_content
          expect(actual).to be_a(Mail::PlainContent)
        end

        it '#patch_settings_plain_content' do
          # get original settings
          actual = @client.get_settings_plain_content
          # patch the value
          actual.enabled = false
          edit = @client.patch_settings_plain_content(params: actual)
          expect(edit.enabled).to eq(false)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:address_whitelist) do
        '{'\
          '"enabled": true,'\
          '"list": ['\
            '"email1@example.com",'\
            '"example.com"'\
          ']'\
        '}'
      end

      it '#get_settings_address_whitelist' do
        allow(client).to receive(:execute).and_return(address_whitelist)
        actual = client.get_settings_address_whitelist
        expect(actual).to be_a(Mail::AddressWhitelist)
      end

      it '#patch_settings_address_whitelist' do
        allow(client).to receive(:execute).and_return(address_whitelist)
        actual = client.patch_settings_address_whitelist(params: nil)
        expect(actual).to be_a(Mail::AddressWhitelist)
      end

      it 'creates address_whitelist instance' do
        actual = Mail.create_address_whitelist(JSON.parse(address_whitelist))
        expect(actual.enabled).to eq(true)
        expect(actual.list).to be_a(Array)
        actual.list.each { |address| expect(address).to be_a(String) }
      end

      let(:bcc) do
        '{'\
          '"enabled": true,'\
          '"email": "email@example.com"'\
        '}'
      end

      it '#get_settings_bcc' do
        allow(client).to receive(:execute).and_return(bcc)
        actual = client.get_settings_bcc
        expect(actual).to be_a(Mail::Bcc)
      end

      it '#patch_settings_bcc' do
        allow(client).to receive(:execute).and_return(bcc)
        actual = client.patch_settings_bcc(params: nil)
        expect(actual).to be_a(Mail::Bcc)
      end

      it 'creates bcc instance' do
        actual = Mail.create_bcc(JSON.parse(bcc))
        expect(actual.enabled).to eq(true)
        expect(actual.email).to eq('email@example.com')
      end

      let(:bounce_purge) do
        '{'\
          '"enabled": true,'\
          '"hard_bounces": 1,'\
          '"soft_bounces": 1'\
        '}'
      end

      it '#get_settings_bounce_purge' do
        allow(client).to receive(:execute).and_return(bounce_purge)
        actual = client.get_settings_bounce_purge
        expect(actual).to be_a(Mail::BouncePurge)
      end

      it '#patch_settings_bounce_purge' do
        allow(client).to receive(:execute).and_return(bounce_purge)
        actual = client.patch_settings_bounce_purge(params: nil)
        expect(actual).to be_a(Mail::BouncePurge)
      end

      it 'creates bounce_purge instance' do
        actual = Mail.create_bounce_purge(JSON.parse(bounce_purge))
        expect(actual.enabled).to eq(true)
        expect(actual.hard_bounces).to eq(1)
        expect(actual.soft_bounces).to eq(1)
      end

      let(:footer) do
        '{'\
          '"enabled": true,'\
          '"html_content": "abc...",'\
          '"plain_content": "xyz..."'\
        '}'
      end

      it '#get_settings_footer' do
        allow(client).to receive(:execute).and_return(footer)
        actual = client.get_settings_footer
        expect(actual).to be_a(Mail::Footer)
      end

      it '#patch_settings_footer' do
        allow(client).to receive(:execute).and_return(footer)
        actual = client.patch_settings_footer(params: nil)
        expect(actual).to be_a(Mail::Footer)
      end

      it 'creates footer instance' do
        actual = Mail.create_footer(JSON.parse(footer))
        expect(actual.enabled).to eq(true)
        expect(actual.html_content).to eq('abc...')
        expect(actual.plain_content).to eq('xyz...')
      end

      let(:forward_bounce) do
        '{'\
          '"enabled": true,'\
          '"email": "email address"'\
        '}'
      end

      it '#get_settings_forward_bounce' do
        allow(client).to receive(:execute).and_return(forward_bounce)
        actual = client.get_settings_forward_bounce
        expect(actual).to be_a(Mail::ForwardBounce)
      end

      it '#patch_settings_forward_bounce' do
        allow(client).to receive(:execute).and_return(forward_bounce)
        actual = client.patch_settings_forward_bounce(params: nil)
        expect(actual).to be_a(Mail::ForwardBounce)
      end

      it 'creates forward_bounce instance' do
        actual = Mail.create_forward_bounce(JSON.parse(forward_bounce))
        expect(actual.enabled).to eq(true)
        expect(actual.email).to eq('email address')
      end

      let(:forward_spam) do
        '{'\
          '"enabled": true,'\
          '"email": "email address"'\
        '}'
      end

      it '#get_settings_forward_spam' do
        allow(client).to receive(:execute).and_return(forward_spam)
        actual = client.get_settings_forward_spam
        expect(actual).to be_a(Mail::ForwardSpam)
      end

      it '#patch_settings_forward_spam' do
        allow(client).to receive(:execute).and_return(forward_spam)
        actual = client.patch_settings_forward_spam(params: nil)
        expect(actual).to be_a(Mail::ForwardSpam)
      end

      it 'creates forward_spam instance' do
        actual = Mail.create_forward_spam(JSON.parse(forward_spam))
        expect(actual.enabled).to eq(true)
        expect(actual.email).to eq('email address')
      end

      let(:spam_check) do
        '{'\
          '"enabled": true,'\
          '"url": "url",'\
          '"max_score": 5'\
        '}'
      end

      it '#get_settings_spam_check' do
        allow(client).to receive(:execute).and_return(spam_check)
        actual = client.get_settings_spam_check
        expect(actual).to be_a(Mail::SpamCheck)
      end

      it '#patch_settings_spam_check' do
        allow(client).to receive(:execute).and_return(spam_check)
        actual = client.patch_settings_spam_check(params: nil)
        expect(actual).to be_a(Mail::SpamCheck)
      end

      it 'creates spam_check instance' do
        actual = Mail.create_spam_check(JSON.parse(spam_check))
        expect(actual.enabled).to eq(true)
        expect(actual.url).to eq('url')
        expect(actual.max_score).to eq(5)
      end

      let(:template) do
        '{'\
          '"enabled": true,'\
          '"html_content": "..."'\
        '}'
      end

      it '#get_settings_template' do
        allow(client).to receive(:execute).and_return(template)
        actual = client.get_settings_template
        expect(actual).to be_a(Mail::Template)
      end

      it '#patch_settings_template' do
        allow(client).to receive(:execute).and_return(template)
        actual = client.patch_settings_template(params: nil)
        expect(actual).to be_a(Mail::Template)
      end

      it 'creates template instance' do
        actual = Mail.create_template(JSON.parse(template))
        expect(actual.enabled).to eq(true)
        expect(actual.html_content).to eq('...')
      end

      let(:plain_content) do
        '{'\
          '"enabled": true'\
        '}'
      end

      it '#get_settings_plain_content' do
        allow(client).to receive(:execute).and_return(plain_content)
        actual = client.get_settings_plain_content
        expect(actual).to be_a(Mail::PlainContent)
      end

      it '#patch_settings_plain_content' do
        allow(client).to receive(:execute).and_return(plain_content)
        actual = client.patch_settings_plain_content(params: nil)
        expect(actual).to be_a(Mail::PlainContent)
      end

      it 'creates plain_content instance' do
        actual = Mail.create_plain_content(JSON.parse(plain_content))
        expect(actual.enabled).to eq(true)
      end
    end
  end
end
