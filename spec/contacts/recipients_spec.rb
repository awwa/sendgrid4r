# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Recipients' do
  before :all do
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
  end

  context 'always' do
    it 'is normal' do
      begin
        # celan up test env
        recipients = @client.get_recipients
        expect(recipients.recipients.length >= 0).to eq(true)
        recipients.recipients.each do |recipient|
          next if recipient.email != @email1
          @client.delete_recipient(recipient.id)
        end
        custom_fields = @client.get_custom_fields
        custom_fields.custom_fields.each do |custom_field|
          next if custom_field.name != @custom_field_name
          @client.delete_custom_field(custom_field.id)
        end
        @client.post_custom_field(@custom_field_name, 'text')
        # post a list
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        new_recipient = @client.post_recipient(params)
        expect(new_recipient.created_at.is_a?(Fixnum)).to eq(true)
        new_recipient.custom_fields.each do |custom_field|
          expect(
            custom_field.is_a?(
              SendGrid4r::REST::Contacts::CustomFields::Field
            )
          ).to eq(true)
        end
        expect(new_recipient.email).to eq(@email1)
        expect(new_recipient.first_name).to eq(nil)
        expect(new_recipient.id).to eq(@email1)
        expect(new_recipient.last_clicked).to eq(nil)
        expect(new_recipient.last_emailed).to eq(nil)
        expect(new_recipient.last_name).to eq(@last_name1)
        expect(new_recipient.last_opened).to eq(nil)
        expect(new_recipient.updated_at.is_a?(Fixnum)).to eq(true)
        # post same recipients
        @client.post_recipient(params)
        # get all recipients
        recipients = @client.get_recipients(100, 0)
        expect(recipients.recipients.length).to eq(2)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
          ).to eq(true)
        end
        # get multiple recipients
        # TODO: returns {"errors":[{"message":"no valid record ids provided"}]}
        # recipient_ids = [@email1, @email2]
        # actual_recipients = @client.get_recipients_by_id(recipient_ids)
        # expect(actual_recipients.recipients.is_a?(Array)).to eq(true)
        # actual_recipients.recipients.each do |recipient|
        #   expect(
        #     recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
        #   ).to eq(true)
        # end
        # read a count of recipients
        actual_count = @client.get_recipients_count
        expect(actual_count).to eq(2)
        # Search recipients
        params = {}
        params['email'] = @email1
        recipients = @client.search_recipients(params)
        expect(recipients.recipients.length).to eq(1)
        # get a single recipient
        recipient = @client.get_recipient(new_recipient.id)
        expect(
          recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
        ).to eq(true)
        # List the recipient lists to which the recipient belongs
        lists = @client.get_lists_recipient_belong(new_recipient.id)
        lists.lists.each do |list|
          expect(
            list.is_a?(SendGrid4r::REST::Contacts::Lists::List)
          ).to eq(true)
        end
        # add multiple recipients
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
          expect(index.is_a?(Fixnum)).to eq(true)
        end
        expect(result.new_count).to eq(0)
        expect(result.updated_count).to eq(2)
        # delete a recipient
        @client.delete_recipient(new_recipient.id)
        expect do
          @client.get_recipient(new_recipient.id)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => e
        puts e.inspect
        raise e
      end
    end

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
      expect(actual.created_at).to eq(1422313607)
      expect(actual.email).to eq('jones@example.com')
      expect(actual.first_name).to eq(nil)
      expect(actual.id).to eq('jones@example.com')
      expect(actual.last_clicked).to eq(nil)
      expect(actual.last_emailed).to eq(nil)
      expect(actual.last_name).to eq('Jones')
      expect(actual.last_opened).to eq(nil)
      expect(actual.updated_at).to eq(1422313790)
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
      expect(actual.recipients.is_a?(Array)).to eq(true)
      actual.recipients.each do |recipient|
        expect(
          recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
        ).to eq(true)
      end
    end
  end
end
