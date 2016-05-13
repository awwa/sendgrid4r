# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe SendGrid4r::REST::InvalidEmails do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @emails = [
          'a1@invalid_email.com', 'a2@invalid_email.com', 'a3@invalid_email.com'
        ]
      end

      context 'without block call' do
        it '#get_invalid_emails' do
          start_time = Time.now - 60 * 60 * 24 * 365
          end_time = Time.now
          invalid_emails = @client.get_invalid_emails(
            start_time: start_time, end_time: end_time
          )
          expect(invalid_emails).to be_a(Array)
          invalid_emails.each do |invalid_email|
            expect(invalid_email).to be_a(InvalidEmails::InvalidEmail)
          end
        end

        it '#delete_invalid_emails(delete_all: true)' do
          @client.delete_invalid_emails(delete_all: true)
        end

        it '#delete_invalid_emails(emails: [])' do
          @client.delete_invalid_emails(emails: @emails)
        end

        it '#get_invalid_email' do
          invalid_email = @client.get_invalid_email(email: @email)
          expect(invalid_email).to be_a(Array)
        end

        it '#delete_invalid_email' do
          expect do
            @client.delete_invalid_email(email: 'a1@invalid_email.com')
          end.to raise_error(RestClient::ResourceNotFound)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:invalid_emails) do
        JSON.parse(
          '['\
            '{'\
              '"created": 1449953655,'\
              '"email": "user1@example.com",'\
              '"reason": "Mail domain mentioned in email address is unknown"'\
            '},'\
            '{'\
              '"created": 1449939373,'\
              '"email": "user1@example.com",'\
              '"reason": "Mail domain mentioned in email address is unknown"'\
            '}'\
          ']'
        )
      end

      let(:invalid_email) do
        JSON.parse(
          '{'\
            '"created": 1454433146,'\
            '"email": "test1@example.com",'\
            '"reason": "Mail domain mentioned in email address is unknown"'\
          '}'\
        )
      end

      it '#get_invalid_emails' do
        allow(client).to receive(:execute).and_return(invalid_emails)
        actual = client.get_invalid_emails
        expect(actual).to be_a(Array)
        actual.each do |invalid_email|
          expect(invalid_email).to be_a(InvalidEmails::InvalidEmail)
        end
      end

      it '#delete_invalid_emails(delete_all: true)' do
        allow(client).to receive(:execute).and_return('')
        client.delete_invalid_emails(delete_all: true)
      end

      it '#delete_invalid_emails(emails: [])' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_invalid_emails(emails: [])
        expect(actual).to eq('')
      end

      it '#get_invalid_email' do
        allow(client).to receive(:execute).and_return(invalid_emails)
        actual = client.get_invalid_email(email: '')
        expect(actual).to be_a(Array)
        actual.each do |invalid_email|
          expect(invalid_email).to be_a(InvalidEmails::InvalidEmail)
        end
      end

      it '#delete_invalid_email' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_invalid_email(email: '')
        expect(actual).to eq('')
      end

      it 'creates invalid_emails instance' do
        actual = InvalidEmails.create_invalid_emails(
          invalid_emails
        )
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(InvalidEmails::InvalidEmail)
        end
      end

      it 'creates invalid_email instance' do
        actual = InvalidEmails.create_invalid_email(
          invalid_email
        )
        expect(actual).to be_a(InvalidEmails::InvalidEmail)
        expect(actual.created).to eq(Time.at(1454433146))
        expect(actual.email).to eq('test1@example.com')
        expect(actual.reason).to eq(
          'Mail domain mentioned in email address is unknown'
        )
      end
    end
  end
end
