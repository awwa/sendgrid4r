# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Bounces do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @emails = ['a1@bounce.com', 'a2@bounce.com', 'a3@bounce.com']
      end

      context 'without block call' do
        it '#get_bounces' do
          start_time = Time.now - 60 * 60 * 24 * 365
          end_time = Time.now
          bounces = @client.get_bounces(
            start_time: start_time, end_time: end_time
          )
          expect(bounces).to be_a(Array)
          bounces.each do |bounce|
            expect(bounce).to be_a(Bounces::Bounce)
          end
        end

        it '#delete_bounces(delete_all: true)' do
          @client.delete_bounces(delete_all: true)
        end

        it '#delete_bounces(emails: [])' do
          @client.delete_bounces(emails: @emails)
        end

        it '#get_bounce' do
          bounce = @client.get_bounce(email: @email)
          expect(bounce).to be_a(Array)
        end

        it '#delete_bounce' do
          expect do
            @client.delete_bounce(email: 'a1@bounce.com')
          end.to raise_error(RestClient::ResourceNotFound)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:bounces) do
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
            '"reason": "550 5.1.1 <testemail2@testing.com>: '\
              'Recipient address '\
            'rejected: User unknown in virtual alias table ",'\
            '"status": "5.1.1"'\
          '}'\
        ']'
      end

      let(:bounce) do
        '{'\
          '"created": 1433800303,'\
          '"email": "testemail2@testing.com",'\
          '"reason": "550 5.1.1 <testemail2@testing.com>: Recipient address '\
          'rejected: User unknown in virtual alias table ",'\
          '"status": "5.1.1"'\
        '}'
      end

      it '#get_bounces' do
        allow(client).to receive(:execute).and_return(bounces)
        actual = client.get_bounces
        expect(actual).to be_a(Array)
        actual.each do |bounce|
          expect(bounce).to be_a(Bounces::Bounce)
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
          expect(bounce).to be_a(Bounces::Bounce)
        end
      end

      it '#delete_bounce' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_bounce(email: '')
        expect(actual).to eq('')
      end

      it 'creates bounces instance' do
        actual = Bounces.create_bounces(JSON.parse(bounces))
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(Bounces::Bounce)
        end
      end

      it 'creates bounce instance' do
        actual = Bounces.create_bounce(JSON.parse(bounce))
        expect(actual).to be_a(Bounces::Bounce)
        expect(actual.created).to eq(Time.at(1433800303))
        expect(actual.email).to eq('testemail2@testing.com')
        expect(actual.reason).to eq(
          '550 5.1.1 <testemail2@testing.com>: '\
          'Recipient address rejected: User unknown in virtual alias table '
        )
        expect(actual.status).to eq('5.1.1')
      end
    end
  end
end
