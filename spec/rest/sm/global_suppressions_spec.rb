# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Sm::GlobalSuppressions do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @email1 = 'test1@test.com'
        @email2 = 'test2@test.com'
        @email3 = 'test3@test.com'

        actual_email1 = @client.get_global_suppressed_email(
          email_address: @email1
        )
        actual_email2 = @client.get_global_suppressed_email(
          email_address: @email2
        )
        actual_email3 = @client.get_global_suppressed_email(
          email_address: @email3
        )
        @client.delete_global_suppressed_email(
          email_address: @email1
        ) if actual_email1 == @email1
        @client.delete_global_suppressed_email(
          email_address: @email2
        ) if actual_email2 == @email2
        @client.delete_global_suppressed_email(
          email_address: @email3
        ) if actual_email3 == @email3
        @client.post_global_suppressed_emails(
          recipient_emails: [@email1]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_global_unsubscribes' do
        begin
          global_suppressions = @client.get_global_unsubscribes
          expect(global_suppressions).to be_a(Array)
          global_suppressions.each do |global_suppression|
            expect(global_suppression).to be_a(
              SendGrid4r::REST::Sm::GlobalSuppressions::Suppression
            )
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#post_global_suppressed_emails' do
        begin
          emails = @client.post_global_suppressed_emails(
            recipient_emails: [@email2, @email3]
          )
          expect(emails.recipient_emails.length).to eq(2)
          expect(emails.recipient_emails.include? @email2).to eq(true)
          expect(emails.recipient_emails.include? @email3).to eq(true)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_global_suppressed_email' do
        begin
          actual_email1 = @client.get_global_suppressed_email(
            email_address: @email1
          )
          actual_notexist = @client.get_global_suppressed_email(
            email_address: 'notexist'
          )
          expect(actual_email1.recipient_email).to eq(@email1)
          expect(actual_notexist.recipient_email).to eq(nil)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_global_suppressed_email' do
        begin
          expect(
            @client.delete_global_suppressed_email(email_address: @email1)
          ).to eq('')
          expect(
            @client.delete_global_suppressed_email(email_address: @email2)
          ).to eq('')
          expect(
            @client.delete_global_suppressed_email(email_address: @email3)
          ).to eq('')
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

    let(:recipient_emails) do
      JSON.parse(
        '{'\
          '"recipient_emails": ['\
            '"test1@example.com",'\
            '"test2@example.com"'\
          ']'\
        '}'
      )
    end

    let(:recipient_email) do
      JSON.parse(
        '{'\
          '"recipient_email": "test1@example.com"'\
        '}'
      )
    end

    it '#post_global_suppressed_emails' do
      allow(client).to receive(:execute).and_return(recipient_emails)
      emails = client.post_global_suppressed_emails(recipient_emails: [])
      expect(emails).to be_a(SendGrid4r::REST::Sm::RecipientEmails)
    end

    it '#get_global_suppressed_email' do
      allow(client).to receive(:execute).and_return(recipient_email)
      actual = client.get_global_suppressed_email(email_address: '')
      expect(actual).to be_a(SendGrid4r::REST::Sm::RecipientEmail)
    end

    it '#delete_global_suppressed_email' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_global_suppressed_email(email_address: '')
      expect(actual).to eq('')
    end
  end
end
