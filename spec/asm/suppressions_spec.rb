# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Asm::Suppressions do
  describe 'integration test' do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
        @email1 = 'test1@test.com'
        @email2 = 'test2@test.com'
        @email3 = 'test3@test.com'
        @group_name = 'suppressions_test'
        @group_desc = 'group_desc'

        # celan up test env
        grps = @client.get_groups
        grps.each do |grp|
          next if grp.name != @group_name
          emails = @client.get_suppressed_emails(grp.id)
          emails.each do |email|
            @client.delete_suppressed_email(grp.id, email)
          end
          @client.delete_group(grp.id)
        end
        # post a group
        @group = @client.post_group(@group_name, @group_desc)
        # post suppressed email
        @client.post_suppressed_emails(@group.id, [@email1])
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'wthout block call' do
      it '#post_suppressed_emails' do
        begin
          emails = @client.post_suppressed_emails(
            @group.id, [@email2, @email3]
          )
          expect(emails.recipient_emails.length).to eq(2)
          expect(emails.recipient_emails[0]).to eq(@email2)
          expect(emails.recipient_emails[1]).to eq(@email3)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_suppressed_emails' do
        begin
          emails = @client.get_suppressed_emails(@group.id)
          expect(emails.length).to eq(1)
          expect(emails[0]).to eq(@email1)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_suppressions' do
        begin
          suppressions = @client.get_suppressions(@email1)
          expect(suppressions.suppressions).to be_a(Array)
          suppressions.suppressions.each do |suppression|
            next unless suppression.name == @group_name
            expect(suppression.name).to eq(@group_name)
            expect(suppression.description).to eq(@group_desc)
            expect(suppression.suppressed).to eq(true)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_suppressed_email' do
        begin
          @client.delete_suppressed_email(@group.id, @email1)
          @client.delete_suppressed_email(@group.id, @email2)
          @client.delete_suppressed_email(@group.id, @email3)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'wthout block call' do
      it '#post_suppressed_emails' do
        @client.post_suppressed_emails(
          @group.id, [@email2, @email3]
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

      it '#get_suppressed_emails' do
        @client.get_suppressed_emails(@group.id) do |resp, req, res|
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_suppressions' do
        @client.get_suppressions(@email1) do |resp, req, res|
          resp =
            SendGrid4r::REST::Asm::Suppressions.create_suppressions(resp)
          expect(resp).to be_a(SendGrid4r::REST::Asm::Suppressions::Suppressions)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_suppressed_email' do
        @client.delete_suppressed_email(@group.id, @email1) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end
  end

  describe 'unit test' do
    it 'creates suppressions instance' do
      json =
        '{'\
          '"suppressions": ['\
            '{'\
              '"id": 1,'\
              '"name": "Weekly Newsletter",'\
              '"description": "The weekly newsletter",'\
              '"suppressed": false'\
            '},'\
            '{'\
              '"id": 4,'\
              '"name": "Special Offers",'\
              '"description": "Special offers and coupons",'\
              '"suppressed": false'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Asm::Suppressions.create_suppressions(hash)
      expect(actual).to be_a(
        SendGrid4r::REST::Asm::Suppressions::Suppressions
      )
    end
  end
end
