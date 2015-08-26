# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Users do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_user_profile' do
        begin
          profile = @client.get_user_profile
          expect(profile).to be_a(SendGrid4r::REST::Users::Profile)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_user_profile' do
        begin
          params = {}
          params['city'] = 'nakano'
          profile = @client.patch_user_profile(params: params)
          expect(profile).to be_a(SendGrid4r::REST::Users::Profile)
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

    let(:profile) do
      JSON.parse(
        '{'\
          '"address":"814 West Chapman Avenue",'\
          '"city":"Orange",'\
          '"company":"SendGrid",'\
          '"country":"US",'\
          '"first_name":"Test",'\
          '"last_name":"User",'\
          '"phone":"555-555-5555",'\
          '"state":"CA",'\
          '"website":"http://www.sendgrid.com",'\
          '"zip":"92868"'\
        '}'
      )
    end

    it '#get_user_profile' do
      allow(client).to receive(:execute).and_return(profile)
      actual = client.get_user_profile
      expect(actual).to be_a(SendGrid4r::REST::Users::Profile)
      expect(actual.address).to eq('814 West Chapman Avenue')
      expect(actual.city).to eq('Orange')
      expect(actual.company).to eq('SendGrid')
      expect(actual.first_name).to eq('Test')
      expect(actual.last_name).to eq('User')
      expect(actual.phone).to eq('555-555-5555')
      expect(actual.state).to eq('CA')
      expect(actual.website).to eq('http://www.sendgrid.com')
      expect(actual.zip).to eq('92868')
    end
  end
end
