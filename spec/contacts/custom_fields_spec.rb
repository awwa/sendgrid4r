# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Contacts::CustomFields do
  describe 'integration test' do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
        @name1 = 'birthday'
        @type1 = 'text'
        @name2 = 'born_at'
        @type2 = 'date'

        # celan up test env
        fields = @client.get_custom_fields
        fields.custom_fields.each do |field|
          next if field.name != @name1 && field.name != @name2
          @client.delete_custom_field(field.id)
        end
        # post a custom field
        @new_field = @client.post_custom_field(@name1, @type1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#post_custom_field' do
        begin
          new_field = @client.post_custom_field(@name2, @type2)
          expect(new_field.id).to be_a(Fixnum)
          expect(new_field.name).to eq(@name2)
          expect(new_field.type).to eq(@type2)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#post_custom_field for same key' do
        begin
          expect do
            @client.post_custom_field(@name1, @type1)
          end.to raise_error(RestClient::BadRequest)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_custom_fields' do
        begin
          fields = @client.get_custom_fields
          expect(fields.length).to be >= 1
          fields.custom_fields.each do |field|
            next if field.name != @name1
            expect(field.id).to eq(@new_field.id)
            expect(field.name).to eq(@new_field.name)
            expect(field.type).to eq(@new_field.type)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_custom_field' do
        begin
          actual_field = @client.get_custom_field(@new_field.id)
          expect(actual_field.id).to eq(@new_field.id)
          expect(actual_field.name).to eq(@new_field.name)
          expect(actual_field.type).to eq(@new_field.type)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_custom_field' do
        begin
          @client.delete_custom_field(@new_field.id)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#post_custom_field' do
        @client.post_custom_field(@name2, @type2) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::CustomFields.create_field(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::CustomFields::Field)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#post_custom_field for same key' do
        @client.post_custom_field(@name1, @type1) do |_resp, req, res|
          # TODO: _resp
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPBadRequest)
        end
      end

      it '#get_custom_fields' do
        @client.get_custom_fields do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::CustomFields.create_fields(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::CustomFields::Fields)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_custom_field' do
        @client.get_custom_field(@new_field.id) do |resp, req, res|
          resp = SendGrid4r::REST::Contacts::CustomFields.create_field(
            JSON.parse(resp)
          )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::CustomFields::Field)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_custom_field' do
        @client.delete_custom_field(@new_field.id) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end
  end

  describe 'unit test' do
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
      expect(actual.custom_fields).to be_a(Array)
      actual.custom_fields.each do |field|
        expect(field).to be_a(SendGrid4r::REST::Contacts::CustomFields::Field)
      end
    end
  end
end
