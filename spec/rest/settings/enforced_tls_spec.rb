# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Settings
  describe EnforcedTls do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      end

      context 'without block call' do
        it '#get_enforced_tls' do
          actual = @client.get_enforced_tls
          expect(actual).to be_a(EnforcedTls::EnforcedTls)
        end

        it '#patch_enforced_tls' do
          # get original enforced_tls settings
          actual = @client.get_enforced_tls
          # patch both value
          actual.require_tls = false
          actual.require_valid_cert = false
          edit = @client.patch_enforced_tls(params: actual)
          expect(actual.require_tls).to eq(edit.require_tls)
          expect(actual.require_valid_cert).to eq(edit.require_valid_cert)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:enforced_tls) do
        '{'\
          '"require_tls": true,'\
          '"require_valid_cert": false'\
        '}'
      end

      it '#get_enforced_tls' do
        allow(client).to receive(:execute).and_return(enforced_tls)
        actual = client.get_enforced_tls
        expect(actual).to be_a(EnforcedTls::EnforcedTls)
      end

      it '#patch_enforced_tls' do
        allow(client).to receive(:execute).and_return(enforced_tls)
        actual = client.patch_enforced_tls(params: nil)
        expect(actual).to be_a(EnforcedTls::EnforcedTls)
      end

      it 'creates enforced_tls instance' do
        actual = EnforcedTls.create_enforced_tls(JSON.parse(enforced_tls))
        expect(actual.require_tls).to eq(true)
        expect(actual.require_valid_cert).to eq(false)
      end
    end
  end
end
