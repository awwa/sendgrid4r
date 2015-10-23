# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Bounces do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @emails = ['a1@bounce.com', 'a2@bounce.com', 'a3@bounce.com']
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_bounces' do
        begin
          bounces = @client.get_bounces
          expect(bounces).to be_a(Array)
          bounces.each do |bounce|
            expect(bounce).to be_a(SendGrid4r::REST::Bounces::Bounce)
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_bounces(delete_all: true)' do
        begin
          @client.delete_bounces(delete_all: true)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_bounces(emails: [])' do
        begin
          @client.delete_bounces(emails: @emails)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_bounce' do
        begin
          bounce = @client.get_bounce(email: @email)
          expect(bounce).to be_a(Array)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_bounce' do
        begin
          expect {
            @client.delete_bounce(email: 'a1@bounce.com')
          }.to raise_error( RestClient::ResourceNotFound )
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

    let(:bounces) do
      JSON.parse(
        '['\
          '{'\
            '"created": 1443651125,'\
            '"email": "testemail1@test.com",'\
            '"reason": "550 5.1.1 The email account that you tried to reach '\
            'does not exist.'\
            'Please try double-checking the recipient\'s email address for '\
            'typos or unnecessary spaces. Learn more at '\
            'https://support.google.com/mail/answer/6596'\
            'o186si2389584ioe.63 - gsmtp ",'\
            '"status": "5.1.1"'\
          '},'\
          '{'\
            '"created": 1433800303,'\
            '"email": "testemail2@testing.com",'\
            '"reason": "550 5.1.1 <testemail2@testing.com>: Recipient address '\
            'rejected: User unknown in virtual alias table ",'\
            '"status": "5.1.1"'\
          '}'\
        ']'
      )
    end

    let(:bounce) do
      JSON.parse(
        '{'\
          '"created": 1433800303,'\
          '"email": "testemail2@testing.com",'\
          '"reason": "550 5.1.1 <testemail2@testing.com>: Recipient address '\
          'rejected: User unknown in virtual alias table ",'\
          '"status": "5.1.1"'\
        '}'
       )
    end

    it '#get_bounces' do
      allow(client).to receive(:execute).and_return(bounces)
      actual = client.get_bounces
      expect(actual).to be_a(Array)
      actual.each do |bounce|
        expect(bounce).to be_a(SendGrid4r::REST::Bounces::Bounce)
      end
    end

    it '#delete_bounces(delete_all: true)' do
      allow(client).to receive(:execute).and_return('')
      client.delete_bounces(delete_all: true)
    end

    it '#delete_bounces(emails: [])' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_bounces(emails: [])
      expect(actual).to eq('')
    end

    it '#get_bounce' do
      allow(client).to receive(:execute).and_return(bounces)
      actual = client.get_bounce(email: '')
      expect(actual).to be_a(Array)
      actual.each do |bounce|
        expect(bounce).to be_a(SendGrid4r::REST::Bounces::Bounce)
      end
    end

    it '#delete_bounce' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_bounce(email: '')
      expect(actual).to eq('')
    end

    it 'creates bounces instance' do
      actual = SendGrid4r::REST::Bounces.create_bounces(bounces)
      expect(actual).to be_a(Array)
      actual.each do |subuser|
        expect(subuser).to be_a(SendGrid4r::REST::Bounces::Bounce)
      end
    end

    it 'creates bounce instance' do
      actual = SendGrid4r::REST::Bounces.create_bounce(bounce)
      expect(actual).to be_a(SendGrid4r::REST::Bounces::Bounce)
      expect(actual.created).to eq(1433800303)
      expect(actual.email).to eq('testemail2@testing.com')
      expect(actual.reason).to eq(
        '550 5.1.1 <testemail2@testing.com>: '\
        'Recipient address rejected: User unknown in virtual alias table '
      )
      expect(actual.status).to eq('5.1.1')
    end
  end
end
