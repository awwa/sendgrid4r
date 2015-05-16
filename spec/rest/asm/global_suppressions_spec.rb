# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Asm::GlobalSuppressions do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          username: ENV['SENDGRID_USERNAME'],
          password: ENV['SENDGRID_PASSWORD'])
        @email1 = 'test1@test.com'
        @email2 = 'test2@test.com'
        @email3 = 'test3@test.com'

        actual_email1 = @client.get_global_suppressed_email(@email1)
        actual_email2 = @client.get_global_suppressed_email(@email2)
        actual_email3 = @client.get_global_suppressed_email(@email3)
        @client.delete_global_suppressed_email(
          @email1
        ) if actual_email1 == @email1
        @client.delete_global_suppressed_email(
          @email2
        ) if actual_email2 == @email2
        @client.delete_global_suppressed_email(
          @email3
        ) if actual_email3 == @email3
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#post_global_suppressed_emails' do
        begin
          emails = @client.post_global_suppressed_emails(
            [@email1, @email2, @email3]
          )
          expect(emails.recipient_emails.length).to eq(3)
          expect(emails.recipient_emails.include? @email1).to eq(true)
          expect(emails.recipient_emails.include? @email2).to eq(true)
          expect(emails.recipient_emails.include? @email3).to eq(true)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_global_suppressed_email' do
        begin
          actual_email1 = @client.get_global_suppressed_email(@email1)
          actual_email2 = @client.get_global_suppressed_email(@email2)
          actual_email3 = @client.get_global_suppressed_email(@email3)
          actual_notexist = @client.get_global_suppressed_email('notexist')
          expect(actual_email1.recipient_email).to eq(@email1)
          expect(actual_email2.recipient_email).to eq(@email2)
          expect(actual_email3.recipient_email).to eq(@email3)
          expect(actual_notexist.recipient_email).to eq(nil)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_global_suppressed_email' do
        begin
          expect(@client.delete_global_suppressed_email(@email1)).to eq('')
          expect(@client.delete_global_suppressed_email(@email2)).to eq('')
          expect(@client.delete_global_suppressed_email(@email3)).to eq('')
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#post_global_suppressed_emails' do
        @client.post_global_suppressed_emails(
          [@email1, @email2, @email3]
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Asm.create_recipient_emails(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Asm::RecipientEmails
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#get_global_suppressed_email' do
        @client.get_global_suppressed_email(@email1) do |resp, req, res|
          resp =
            SendGrid4r::REST::Asm.create_recipient_email(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Asm::RecipientEmail
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_global_suppressed_email' do
        @client.delete_global_suppressed_email(@email1) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
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
      emails = client.post_global_suppressed_emails([])
      expect(emails).to be_a(SendGrid4r::REST::Asm::RecipientEmails)
    end

    it '#get_global_suppressed_email' do
      allow(client).to receive(:execute).and_return(recipient_email)
      actual = client.get_global_suppressed_email('')
      expect(actual).to be_a(SendGrid4r::REST::Asm::RecipientEmail)
    end

    it '#delete_global_suppressed_email' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_global_suppressed_email('')
      expect(actual).to eq('')
    end
  end
end
