# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Webhooks
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @hostname1 = 'host1.abc.abc'
        @hostname2 = 'host2.abc.abc'
        # clean up test env
        settings = @client.get_parse_settings
        settings.result.each do |setting|
          if setting.hostname == @hostname1
            @client.delete_parse_setting(hostname: @hostname1)
          end
          if setting.hostname == @hostname2
            @client.delete_parse_setting(hostname: @hostname2)
          end
        end
        # post parse setting
        @parse_setting1 = @client.post_parse_setting(
          hostname: @hostname1,
          url: 'http://host1.abc.abc',
          spam_check: false,
          send_raw: false
        )
      end

      context 'without block call' do
        it '#get_parse_settings without params' do
          settings = @client.get_parse_settings
          expect(settings).to be_a(Parse::ParseSettings)
          expect(settings.result).to be_a(Array)
        end

        it '#get_parse_settings with full params' do
          settings = @client.get_parse_settings(limit: 1, offset: 0)
          expect(settings).to be_a(Parse::ParseSettings)
          expect(settings.result).to be_a(Array)
        end

        it '#post_parse_setting' do
          setting = @client.post_parse_setting(
            hostname: @hostname2,
            url: 'https://host2.abc.abc',
            spam_check: true,
            send_raw: true
          )
          expect(setting).to be_a(Parse::ParseSetting)
        end

        it '#get_parse_setting' do
          setting = @client.get_parse_setting(
            hostname: @hostname1
          )
          expect(setting).to be_a(Parse::ParseSetting)
        end

        it '#patch_parse_setting' do
          setting = @client.patch_parse_setting(
            hostname: @hostname1,
            url: 'http://host1.ccc.ccc',
            spam_check: true,
            send_raw: true
          )
          expect(setting).to be_a(Parse::ParseSetting)
        end

        it '#delete_parse_setting' do
          @client.delete_parse_setting(hostname: @hostname1)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:parse_settings) do
        '{'\
          '"result": ['\
            '{'\
              '"url": "http://mydomain.com/parse",'\
              '"hostname": "mail.mydomain.com",'\
              '"spam_check": true,'\
              '"send_raw": true'\
            '}'\
          ']'\
        '}'
      end

      let(:parse_setting) do
        '{'\
          '"url": "http://mydomain.com/parse",'\
          '"hostname": "mail.mydomain.com",'\
          '"spam_check": true,'\
          '"send_raw": true'\
        '}'\
      end

      it '#get_parse_settings' do
        allow(client).to receive(:execute).and_return(parse_settings)
        actual = client.get_parse_settings
        expect(actual).to be_a(Parse::ParseSettings)
      end

      it '#post_parse_setting' do
        allow(client).to receive(:execute).and_return(parse_setting)
        actual = client.post_parse_setting(
          hostname: '', url: '', spam_check: true, send_raw: true
        )
        expect(actual).to be_a(Parse::ParseSetting)
      end

      it '#get_parse_setting' do
        allow(client).to receive(:execute).and_return(parse_setting)
        actual = client.get_parse_setting(hostname: '')
        expect(actual).to be_a(Parse::ParseSetting)
      end

      it '#patch_parse_setting' do
        allow(client).to receive(:execute).and_return(parse_setting)
        actual = client.patch_parse_setting(
          hostname: '', url: '', spam_check: true, send_raw: true
        )
        expect(actual).to be_a(Parse::ParseSetting)
      end

      it '#delete_parse_setting' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_parse_setting(hostname: '')
        expect(actual).to eq('')
      end

      it 'creates parse_setting instance' do
        actual = Parse.create_parse_setting(JSON.parse(parse_setting))
        expect(actual).to be_a(Parse::ParseSetting)
        expect(actual.url).to eq('http://mydomain.com/parse')
        expect(actual.hostname).to eq('mail.mydomain.com')
        expect(actual.spam_check).to eq(true)
        expect(actual.send_raw).to eq(true)
      end

      it 'creates parse_settings instance' do
        actual = Parse.create_parse_settings(JSON.parse(parse_settings))
        expect(actual).to be_a(Parse::ParseSettings)
        expect(actual.result).to be_a(Array)
      end
    end
  end
end
