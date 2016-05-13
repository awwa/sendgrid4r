# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Settings
  describe Partner do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#get_partner_settings' do
          actual = @client.get_partner_settings
          expect(actual).to be_a(Results)
        end

        it '#get_settings_new_relic' do
          pending 'invalid json received'
          actual = @client.get_settings_new_relic
          expect(actual).to be_a(Partner::Partner)
        end

        it '#patch_settings_new_relic' do
          pending 'invalid json received'
          # get original settings
          actual = @client.get_settings_new_relic
          # patch the value
          actual.enabled = false
          actual.license_key = 'new_relic_license_key'
          edit = @client.patch_settings_new_relic(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.license_key).to eq('new_relic_license_key')
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:partner) do
        JSON.parse(
          '{'\
            '"enabled": true,'\
            '"license_key": "key"'\
          '}'
        )
      end

      it '#get_settings_new_relic' do
        allow(client).to receive(:execute).and_return(partner)
        actual = client.get_settings_new_relic
        expect(actual).to be_a(Partner::Partner)
      end

      it '#patch_settings_new_relic' do
        allow(client).to receive(:execute).and_return(partner)
        actual = client.patch_settings_new_relic(params: nil)
        expect(actual).to be_a(Partner::Partner)
      end

      it 'creates partner instance' do
        actual = Partner.create_partner(partner)
        expect(actual.enabled).to eq(true)
        expect(actual.license_key).to eq('key')
      end
    end
  end
end
