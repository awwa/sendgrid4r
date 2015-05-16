# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Asm::Suppressions do
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

    context 'with block call' do
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
          resp =
            SendGrid4r::REST::Asm::Suppressions.create_emails(JSON.parse(resp))
          expect(resp).to be_a(Array)
          resp.each do |email|
            expect(email).to be_a(String)
          end
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_suppressions' do
        @client.get_suppressions(@email1) do |resp, req, res|
          resp =
            SendGrid4r::REST::Asm::Suppressions.create_suppressions(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Asm::Suppressions::Suppressions
          )
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

    let(:emails) do
      JSON.parse(
        '["test1@example.com","test2@example.com"]'
      )
    end

    let(:suppression) do
      JSON.parse(
        '{'\
          '"id": 4,'\
          '"name": "Special Offers",'\
          '"description": "Special offers and coupons",'\
          '"suppressed": false'\
        '}'
      )
    end

    let(:suppressions) do
      JSON.parse(
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
      )
    end

    it '#post_suppressed_emails' do
      allow(client).to receive(:execute).and_return(recipient_emails)
      actual = client.post_suppressed_emails(0, ['', ''])
      expect(actual).to be_a(SendGrid4r::REST::Asm::RecipientEmails)
    end

    it '#get_suppressed_emails' do
      allow(client).to receive(:execute).and_return(emails)
      actual = client.get_suppressed_emails(0)
      expect(actual).to be_a(Array)
    end

    it '#get_suppressions' do
      allow(client).to receive(:execute).and_return(suppressions)
      actual = client.get_suppressions('')
      expect(actual.suppressions).to be_a(Array)
      actual.suppressions.each do |suppression|
        expect(suppression).to be_a(
          SendGrid4r::REST::Asm::Suppressions::Suppression
        )
      end
    end

    it '#delete_suppressed_email' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_suppressed_email(0, '')
      expect(actual).to eq('')
    end

    it 'creates suppression instance' do
      actual = SendGrid4r::REST::Asm::Suppressions.create_suppression(
        suppression
      )
      expect(actual).to be_a(
        SendGrid4r::REST::Asm::Suppressions::Suppression
      )
      expect(actual.id).to eq(4)
      expect(actual.name).to eq('Special Offers')
      expect(actual.description).to eq('Special offers and coupons')
      expect(actual.suppressed).to eq(false)
    end

    it 'creates suppressions instance' do
      actual = SendGrid4r::REST::Asm::Suppressions.create_suppressions(
        suppressions
      )
      expect(actual).to be_a(
        SendGrid4r::REST::Asm::Suppressions::Suppressions
      )
      expect(actual.suppressions).to be_a(Array)
      actual.suppressions.each do |suppression|
        expect(suppression).to be_a(
          SendGrid4r::REST::Asm::Suppressions::Suppression
        )
      end
    end
  end
end
