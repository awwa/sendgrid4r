# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Asm::GlobalSuppressions do
  describe 'integration test' do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
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
end
