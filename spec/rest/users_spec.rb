# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

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

      it '#get_user_account' do
        begin
          account = @client.get_user_account
          expect(account).to be_a(SendGrid4r::REST::Users::Account)
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

    let(:account) do
      JSON.parse(
        '{'\
          '"type": "free",'\
          '"reputation": 99.7'\
        '}'
      )
    end

    it '#get_user_profile' do
      allow(client).to receive(:execute).and_return(profile)
      actual = client.get_user_profile
      expect(actual).to be_a(SendGrid4r::REST::Users::Profile)
    end

    it '#patch_user_profile' do
      allow(client).to receive(:execute).and_return(profile)
      params = {}
      params['city'] = 'nakano'
      actual = client.patch_user_profile(params: params)
      expect(actual).to be_a(SendGrid4r::REST::Users::Profile)
    end

    it '#get_user_account' do
      allow(client).to receive(:execute).and_return(account)
      actual = client.get_user_account
      expect(actual).to be_a(SendGrid4r::REST::Users::Account)
    end

    it 'creates profile instance' do
      actual = SendGrid4r::REST::Users.create_profile(profile)
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

    it 'creates account instance' do
      actual = SendGrid4r::REST::Users.create_account(account)
      expect(actual.type).to eq('free')
      expect(actual.reputation).to eq(99.7)
    end
  end
end
