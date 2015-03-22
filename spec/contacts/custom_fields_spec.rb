# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::CustomFields' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    @name = 'birthday'
    @type = 'text'
  end

  context 'always' do
    it 'is normal' do
      begin
        # celan up test env
        fields = @client.get_custom_fields
        expect(fields.custom_fields.length >= 0).to eq(true)
        fields.custom_fields.each do |field|
          next if field.name != @name
          @client.delete_custom_field(field.id)
        end
        # post a custom field
        new_field = @client.post_custom_field(@name, @type)
        expect(new_field.id.is_a?(Fixnum)).to eq(true)
        expect(new_field.name).to eq(@name)
        expect(new_field.type).to eq(@type)
        # post same custom fieled
        expect do
          @client.post_custom_field(@name, @type)
        end.to raise_error(RestClient::BadRequest)
        # get the custom fields
        fields = @client.get_custom_fields
        expect(fields.length >= 1).to eq(true)
        fields.custom_fields.each do |field|
          next if field.name != @name
          expect(field.id).to eq(new_field.id)
          expect(field.name).to eq(new_field.name)
          expect(field.type).to eq(new_field.type)
        end
        # get a single custom field
        actual_field = @client.get_custom_field(new_field.id)
        expect(actual_field.id).to eq(new_field.id)
        expect(actual_field.name).to eq(new_field.name)
        expect(actual_field.type).to eq(new_field.type)
        # delete the custom field
        @client.delete_custom_field(new_field.id)
        expect do
          @client.get_custom_field(new_field.id)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'creates field instance' do
      json =
        '{'\
          '"id": 1,'\
          '"name": "pet",'\
          '"type": "text"'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::CustomFields.create_field(hash)
      expect(actual.id).to eq(1)
      expect(actual.name).to eq('pet')
      expect(actual.type).to eq('text')
    end

    it 'creates fields instance' do
      json =
        '{'\
          '"custom_fields": ['\
            '{'\
              '"id": 1,'\
              '"name": "birthday",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"id": 2,'\
              '"name": "middle_name",'\
              '"type": "text"'\
            '},'\
            '{'\
              '"id": 3,'\
              '"name": "favorite_number",'\
              '"type": "number"'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::CustomFields.create_fields(hash)
      expect(actual.custom_fields.is_a?(Array)).to eq(true)
      actual.custom_fields.each do |field|
        expect(
          field.is_a?(SendGrid4r::REST::Contacts::CustomFields::Field)
        ).to eq(true)
      end
    end
  end
end
