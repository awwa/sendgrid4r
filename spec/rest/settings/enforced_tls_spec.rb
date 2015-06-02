# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Settings::EnforcedTls do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        username: ENV['SENDGRID_USERNAME'],
        password: ENV['SENDGRID_PASSWORD'])
    end

    context 'without block call' do
      it '#get_enforced_tls' do
        begin
          actual = @client.get_enforced_tls
          expect(
            actual
          ).to be_a(SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_enforced_tls' do
        begin
          # get original enforced_tls settings
          actual = @client.get_enforced_tls
          # patch both value
          actual.require_tls = false
          actual.require_valid_cert = false
          edit = @client.patch_enforced_tls(params: actual)
          expect(actual.require_tls).to eq(edit.require_tls)
          expect(actual.require_valid_cert).to eq(edit.require_valid_cert)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_enforced_tls' do
        @client.get_enforced_tls do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_enforced_tls' do
        # get original enforced_tls settings
        actual = @client.get_enforced_tls
        # patch both value
        actual.require_tls = false
        actual.require_valid_cert = false
        @client.patch_enforced_tls(params: actual) do |resp, req, res|
          resp =
            SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls
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

    let(:enforced_tls) do
      JSON.parse(
        '{'\
          '"require_tls": true,'\
          '"require_valid_cert": false'\
        '}'
      )
    end

    it '#get_enforced_tls' do
      allow(client).to receive(:execute).and_return(enforced_tls)
      actual = client.get_enforced_tls
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls
      )
    end

    it '#patch_enforced_tls' do
      allow(client).to receive(:execute).and_return(enforced_tls)
      actual = client.patch_enforced_tls(params: nil)
      expect(actual).to be_a(
        SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls
      )
    end

    it 'creates enforced_tls instance' do
      actual = SendGrid4r::REST::Settings::EnforcedTls.create_enforced_tls(
        enforced_tls
      )
      expect(actual.require_tls).to eq(true)
      expect(actual.require_valid_cert).to eq(false)
    end
  end
end
