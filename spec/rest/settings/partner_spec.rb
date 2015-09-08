# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Settings::Partner do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
    end

    context 'without block call' do
      it '#get_partner_settings' do
        begin
          actual = @client.get_partner_settings
          expect(
            actual
          ).to be_a(SendGrid4r::REST::Settings::Results)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_new_relic' do
        pending 'invalid json received'
        begin
          actual = @client.get_settings_new_relic
          expect(actual).to be_a(
            SendGrid4r::REST::Settings::Partner::Partner
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_new_relic' do
        pending 'invalid json received'
        begin
          # get original settings
          actual = @client.get_settings_new_relic
          # patch the value
          actual.enabled = false
          actual.license_key = 'new_relic_license_key'
          edit = @client.patch_settings_new_relic(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.license_key).to eq('new_relic_license_key')
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_settings_sendwithus' do
        pending 'entry not found'
        begin
          actual = @client.get_settings_sendwithus
          expect(actual).to be_a(SendGrid4r::REST::Settings::Partner::Partner)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_settings_sendwithus' do
        pending 'entry not found'
        begin
          # get original settings
          actual = @client.get_settings_sendwithus
          # patch the value
          actual.enabled = false
          actual.license_key = 'sendwithus_license_key'
          edit = @client.patch_settings_sendwithus(params: actual)
          expect(edit.enabled).to eq(false)
          expect(edit.license_key).to eq('sendwithus_license_key')
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
      expect(actual).to be_a(SendGrid4r::REST::Settings::Partner::Partner)
    end

    it '#patch_settings_new_relic' do
      allow(client).to receive(:execute).and_return(partner)
      actual = client.patch_settings_new_relic(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Partner::Partner)
    end

    it '#get_settings_sendwithus' do
      allow(client).to receive(:execute).and_return(partner)
      actual = client.get_settings_sendwithus
      expect(actual).to be_a(SendGrid4r::REST::Settings::Partner::Partner)
    end

    it '#patch_settings_sendwithus' do
      allow(client).to receive(:execute).and_return(partner)
      actual = client.patch_settings_sendwithus(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Settings::Partner::Partner)
    end

    it 'creates partner instance' do
      actual = SendGrid4r::REST::Settings::Partner.create_partner(partner)
      expect(actual.enabled).to eq(true)
      expect(actual.license_key).to eq('key')
    end
  end
end
