# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Contacts::Recipients do
  before do
    begin
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
      @email1 = 'jones@example.com'
      @email2 = 'miller@example.com'
      @last_name1 = 'Jones'
      @last_name2 = 'Miller'
      @pet1 = 'Fluffy'
      @pet2 = 'FrouFrou'
      @custom_field_name = 'pet'

      # celan up test env
      recipients = @client.get_recipients
      recipients.recipients.each do |recipient|
        next if recipient.email != @email1 && recipient.email != @email2
        @client.delete_recipient(recipient.id)
      end
      custom_fields = @client.get_custom_fields
      custom_fields.custom_fields.each do |custom_field|
        next if custom_field.name != @custom_field_name
        @client.delete_custom_field(custom_field.id)
      end
      @client.post_custom_field(@custom_field_name, 'text')
      # post a recipient
      params = {}
      params['email'] = @email1
      params['last_name'] = @last_name1
      params[@custom_field_name] = @pet1
      @new_recipient = @client.post_recipient(params)
    rescue => e
      puts e.inspect
      raise e
    end
  end

  context 'without block call' do
    it '#post_recipient' do
      begin
        params = {}
        params['email'] = @email2
        params['last_name'] = @last_name2
        params[@custom_field_name] = @pet2
        new_recipient = @client.post_recipient(params)
        expect(new_recipient.created_at).to be_a(Time)
        new_recipient.custom_fields.each do |custom_field|
          expect(
            custom_field
          ).to be_a(SendGrid4r::REST::Contacts::CustomFields::Field)
        end
        expect(new_recipient.email).to eq(@email2)
        expect(new_recipient.first_name).to eq(nil)
        expect(new_recipient.id).to eq(@email2)
        expect(new_recipient.last_clicked).to eq(nil)
        expect(new_recipient.last_emailed).to eq(nil)
        expect(new_recipient.last_name).to eq(@last_name2)
        expect(new_recipient.last_opened).to eq(nil)
        expect(new_recipient.updated_at).to be_a(Time)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_recipient for same key' do
      begin
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        @client.post_recipient(params)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_recipients' do
      begin
        recipients = @client.get_recipients(100, 0)
        expect(recipients.recipients.length).to be > 0
        recipients.recipients.each do |recipient|
          expect(
            recipient
          ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_recipient_count' do
      begin
        actual_count = @client.get_recipients_count
        expect(actual_count).to be >= 0
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#search_recipients' do
      begin
        params = {}
        params['email'] = @email1
        recipients = @client.search_recipients(params)
        expect(recipients.recipients).to be_a(Array)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_recipient' do
      begin
        recipient = @client.get_recipient(@new_recipient.id)
        expect(
          recipient
        ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_lists_recipient_belong' do
      begin
        lists = @client.get_lists_recipient_belong(@new_recipient.id)
        lists.lists.each do |list|
          expect(
            list.is_a?(SendGrid4r::REST::Contacts::Lists::List)
          ).to eq(true)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_recipients' do
      begin
        recipient1 = {}
        recipient1['email'] = @email1
        recipient1['last_name'] = @last_name1
        recipient1[@custom_field_name] = @pet1
        recipient2 = {}
        recipient2['email'] = @email2
        recipient2['last_name'] = @last_name2
        recipient2[@custom_field_name] = @pet2
        params = [recipient1, recipient2]
        result = @client.post_recipients(params)
        expect(result.error_count).to eq(0)
        result.error_indices.each do |index|
          expect(index).to be_a(Fixnum)
        end
        expect(result.new_count).to be_a(Fixnum)
        expect(result.updated_count).to be_a(Fixnum)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_recipients_by_id' do
      begin
        recipient_ids = [@email1, @email2]
        actual_recipients = @client.get_recipients_by_id(recipient_ids)
        expect(actual_recipients.recipients).to be_a(Array)
        expect(actual_recipients.recipients.length).to eq(1)
        actual_recipients.recipients.each do |recip|
          expect(
            recip
          ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_recipient' do
      begin
        @client.delete_recipient(@new_recipient.id)
        expect do
          @client.get_recipient(@new_recipient.id)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_recipients' do
      begin
        @client.delete_recipients([@email1, @email2])
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    it '#post_recipient' do
      params = {}
      params['email'] = @email2
      params['last_name'] = @last_name2
      params[@custom_field_name] = @pet2
      @client.post_recipient(params) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipient(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end

    it '#delete_recipient' do
      params = {}
      params['email'] = @email1
      params['last_name'] = @last_name1
      params[@custom_field_name] = @pet1
      recipient = @client.post_recipient(params)
      @client.delete_recipient(recipient.id) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end

    it '#get_recipients' do
      @client.get_recipients do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_recipients_by_id' do
      params = {}
      params['email'] = @email1
      params['last_name'] = @last_name1
      params[@custom_field_name] = @pet1
      recipient = @client.post_recipient(params)
      @client.get_recipients_by_id([recipient.id]) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_recipients_count' do
      @client.get_recipients_count do |resp, req, res|
        expect(JSON.parse(resp)['recipient_count']).to be_a(Fixnum)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#search_recipients' do
      params = {}
      params['email'] = @email1
      @client.search_recipients(params) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_recipient' do
      params = {}
      params['email'] = @email1
      params['last_name'] = @last_name1
      params[@custom_field_name] = @pet1
      recipient = @client.post_recipient(params)
      @client.get_recipient(recipient.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipient(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_lists_recipient_belong' do
      params = {}
      params['email'] = @email1
      params['last_name'] = @last_name1
      params[@custom_field_name] = @pet1
      recipient = @client.post_recipient(params)
      @client.get_lists_recipient_belong(recipient.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Lists.create_lists(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Lists::Lists)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#post_recipients' do
      recipient1 = {}
      recipient1['email'] = @email1
      recipient1['last_name'] = @last_name1
      recipient1[@custom_field_name] = @pet1
      recipient2 = {}
      recipient2['email'] = @email2
      recipient2['last_name'] = @last_name2
      recipient2[@custom_field_name] = @pet2
      params = [recipient1, recipient2]
      @client.post_recipients(params) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_result(
            JSON.parse(resp)
          )
        expect(resp).to be_a(
          SendGrid4r::REST::Contacts::Recipients::ResultAddMultiple
        )
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end
  end

  context 'unit test' do
    it 'creates recipient instance' do
      json =
        '{'\
          '"created_at": 1422313607,'\
          '"email": "jones@example.com",'\
          '"first_name": null,'\
          '"id": "jones@example.com",'\
          '"last_clicked": null,'\
          '"last_emailed": null,'\
          '"last_name": "Jones",'\
          '"last_opened": null,'\
          '"updated_at": 1422313790,'\
          '"custom_fields": ['\
            '{'\
              '"id": 23,'\
              '"name": "pet",'\
              '"value": "Fluffy",'\
              '"type": "text"'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Recipients.create_recipient(hash)
      expect(actual.created_at).to eq(Time.at(1422313607))
      expect(actual.email).to eq('jones@example.com')
      expect(actual.first_name).to eq(nil)
      expect(actual.id).to eq('jones@example.com')
      expect(actual.last_clicked).to eq(nil)
      expect(actual.last_emailed).to eq(nil)
      expect(actual.last_name).to eq('Jones')
      expect(actual.last_opened).to eq(nil)
      expect(actual.updated_at).to eq(Time.at(1422313790))
      custom_field = actual.custom_fields[0]
      expect(custom_field.id).to eq(23)
      expect(custom_field.name).to eq('pet')
      expect(custom_field.value).to eq('Fluffy')
      expect(custom_field.type).to eq('text')
    end

    it 'creates recipients instance' do
      json =
        '{'\
          '"recipients": ['\
            '{'\
              '"created_at": 1422313607,'\
              '"email": "jones@example.com",'\
              '"first_name": null,'\
              '"id": "jones@example.com",'\
              '"last_clicked": null,'\
              '"last_emailed": null,'\
              '"last_name": "Jones",'\
              '"last_opened": null,'\
              '"updated_at": 1422313790,'\
              '"custom_fields": ['\
                '{'\
                  '"id": 23,'\
                  '"name": "pet",'\
                  '"value": "Fluffy",'\
                  '"type": "text"'\
                '}'\
              ']'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Recipients.create_recipients(hash)
      expect(actual.recipients).to be_a(Array)
      actual.recipients.each do |recipient|
        expect(
          recipient
        ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
      end
    end
  end
end
