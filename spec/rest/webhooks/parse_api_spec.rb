# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Webhooks::ParseApi do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_parse_settings' do
        pending 'resource not found'
        begin
          parse_settings = @client.get_parse_settings
          expect(parse_settings).to be_a(
            SendGrid4r::REST::Webhooks::ParseApi::ParseSettings
          )
          expect(parse_settings.url).to be_a(String)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:parse_settings) do
      JSON.parse(
        '{'\
          '"url": "http://mydomain.com/parse",'\
          '"hostname": "mail.mydomain.com",'\
          '"spam_check_outgoing": true'\
        '}'
      )
    end

    it '#get_parse_settings' do
      allow(client).to receive(:execute).and_return(parse_settings)
      actual = client.get_parse_settings
      expect(actual).to be_a(
        SendGrid4r::REST::Webhooks::ParseApi::ParseSettings
      )
    end

    it 'creates parse_settings instance' do
      actual = SendGrid4r::REST::Webhooks::ParseApi.create_parse_settings(
        parse_settings
      )
      expect(actual).to be_a(
        SendGrid4r::REST::Webhooks::ParseApi::ParseSettings
      )
      expect(actual.url).to eq('http://mydomain.com/parse')
      expect(actual.hostname).to eq('mail.mydomain.com')
      expect(actual.spam_check_outgoing).to eq(true)
    end
  end
end
