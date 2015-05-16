# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Subusers do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          username: ENV['SILVER_SENDGRID_USERNAME'],
          password: ENV['SILVER_SENDGRID_PASSWORD'])
        @username1 = ENV['SUBUSER1']
        @username2 = ENV['SILVER_SUBUSER']
        @email1 = ENV['SUBMAIL1']
        @password1  = ENV['SUBPASS1']

        @ip = @client.get_ips[0].ip
        # celan up test env
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_subusers' do
        begin
          subusers = @client.get_subusers(limit: 100, offset: 0)
          expect(subusers).to be_a(Array)
          subusers.each do |subuser|
            expect(subuser).to be_a(SendGrid4r::REST::Subusers::Subuser)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#post_subuser' do
        begin
          pending 'got RestClient::Forbidden:'
          subuser2 = @client.post_subuser(
            username: @username2,
            email: @email2,
            password: @password2,
            ips: [@ip]
          )
          expect(subuser2).to be_a(SendGrid4r::REST::Subusers::Subuser)
          expect(subuser2.username).to eq(@username2)
          expect(subuser2.email).to eq(@email2)
          expect(subuser2.password).to eq(@password2)
          expect(subuser2.ips).to be_a(Array)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_subuser_reputation' do
        begin
          subusers = @client.get_subuser_reputation(usernames: [@username2])
          expect(subusers).to be_a(Array)
          subusers.each do |subuser|
            expect(subuser).to be_a(SendGrid4r::REST::Subusers::Subuser)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#put_subuser_assigned_ips' do
        begin
          pending 'Invalid JSON'
          subuser = @client.put_subuser_assigned_ips(username: @username2)
          expect(subuser.ips).to be_a(Array)
          subuser.ips.each do |ip|
            expect(ip).to be_a(String)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_subusers' do
        @client.get_subusers(limit: 100, offset: 0) do |resp, req, res|
          resp =
            SendGrid4r::REST::Subusers.create_subusers(JSON.parse(resp))
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#post_subuser' do
        pending 'got RestClient::Forbidden:'
        @client.post_subuser(
          username: @username2,
          email: @email2,
          password: @password2,
          ips: [@ip]
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Subusers.create_subuser(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::Subusers::Subuser)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#get_subuser_reputation' do
        @client.get_subuser_reputation(
          usernames: [@username2]
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Subusers.create_subusers(JSON.parse(resp))
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#put_subuser_assigned_ips' do
        pending 'Invalid JSON'
        @client.put_subuser_assigned_ips(
          username: @username2
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Subusers.create_subuser(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::Subusers::Subuser)
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

    let(:subusers) do
      JSON.parse(
        '['\
          '{'\
            '"id": 1,'\
            '"username": "Test@example.com",'\
            '"email": "Test@example.com"'\
          '},'\
          '{'\
            '"id": 2,'\
            '"username": "John@example.com",'\
            '"email": "John@example.com"'\
          '}'\
        ']'
      )
    end

    let(:subuser) do
      JSON.parse(
        '{'\
          '"username": "John@example.com",'\
          '"email": "John@example.com",'\
          '"password": "johns_password",'\
          '"ips": ['\
            '"1.1.1.1",'\
            '"2.2.2.2"'\
          ']'\
        '}'
      )
    end

    let(:ips) do
      JSON.parse(
        '{'\
          '"ips": ['\
            '"127.0.0.1",'\
            '"127.0.0.2"'\
          ']'\
        '}'
      )
    end

    it '#get_subusers' do
      allow(client).to receive(:execute).and_return(subusers)
      actual = client.get_subusers(limit: 0, offset: 0, username: 'aaa')
      expect(actual).to be_a(Array)
      actual.each do |subuser|
        expect(subuser).to be_a(SendGrid4r::REST::Subusers::Subuser)
      end
    end

    it '#post_subuser' do
      allow(client).to receive(:execute).and_return(subuser)
      actual = client.post_subuser(
        username: '', email: '', password: '', ips: []
      )
      expect(actual).to be_a(SendGrid4r::REST::Subusers::Subuser)
    end

    it '#get_subuser_reputation' do
      allow(client).to receive(:execute).and_return(subusers)
      actual = client.get_subuser_reputation(usernames: [])
      expect(actual).to be_a(Array)
      actual.each do |subuser|
        expect(subuser).to be_a(SendGrid4r::REST::Subusers::Subuser)
      end
    end

    it '#put_subuser_assigned_ips' do
      pending 'waiting for sendgrid documentation update'
      allow(client).to receive(:execute).and_return(subuser)
      actual = client.put_subuser_assigned_ips('', [])
      expect(actual).to be_a(SendGrid4r::REST::Subusers::Subuser)
    end

    it 'creates subusers instance' do
      actual = SendGrid4r::REST::Subusers.create_subusers(subusers)
      expect(actual).to be_a(Array)
      actual.each do |subuser|
        expect(subuser).to be_a(SendGrid4r::REST::Subusers::Subuser)
      end
    end

    it 'creates subuser instance' do
      actual = SendGrid4r::REST::Subusers.create_subuser(subuser)
      expect(actual).to be_a(SendGrid4r::REST::Subusers::Subuser)
      expect(actual.username).to eq('John@example.com')
      expect(actual.email).to eq('John@example.com')
      expect(actual.password).to eq('johns_password')
      actual.ips do |ip|
        expect(ip).to be_a(String)
      end
    end
  end
end
