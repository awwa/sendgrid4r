# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Contacts::ReservedFields do
  describe 'integration test' do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
      @first_name =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'first_name', 'text'
        )
      @last_name =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'last_name', 'text'
        )
      @email =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'email', 'text'
        )
      @created_at =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'created_at', 'date'
        )
      @updated_at =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'updated_at', 'date'
        )
      @last_emailed =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'last_emailed', 'date'
        )
      @last_clicked =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'last_clicked', 'date'
        )
      @last_opened =
        SendGrid4r::REST::Contacts::ReservedFields::Field.new(
          'last_opened', 'date'
        )
    end

    context 'without block call' do
      it '#get_reserved_fields' do
        begin
          # get the reserved fields
          fields = @client.get_reserved_fields
          expect(fields.reserved_fields.length).to eq(8)
          set = Set.new(fields.reserved_fields)
          expect(set.include?(@first_name)).to eq(true)
          expect(set.include?(@last_name)).to eq(true)
          expect(set.include?(@email)).to eq(true)
          expect(set.include?(@created_at)).to eq(true)
          expect(set.include?(@updated_at)).to eq(true)
          expect(set.include?(@last_emailed)).to eq(true)
          expect(set.include?(@last_clicked)).to eq(true)
          expect(set.include?(@last_opened)).to eq(true)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_reserved_fields' do
        @client.get_reserved_fields do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::ReservedFields.create_fields(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::ReservedFields::Fields)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end
    end
  end

  describe 'unit test' do
    it 'creates field instance' do
      json =
        '{'\
          '"name": "first_name",'\
          '"type": "text"'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::CustomFields.create_field(hash)
      expect(actual.name).to eq('first_name')
      expect(actual.type).to eq('text')
    end

    it 'creates fields instance' do
      json =
        '{'\
          '"reserved_fields": ['\
            '{'\
              '"name": "first_name",'\
              '"type": "text"'\
            '},'\
            '{'\
              '"name": "last_name",'\
              '"type": "text"'\
            '},'\
            '{'\
              '"name": "email",'\
              '"type": "text"'\
            '},'\
            '{'\
              '"name": "created_at",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"name": "updated_at",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"name": "last_emailed",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"name": "last_clicked",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"name": "last_opened",'\
              '"type": "date"'\
            '},'\
            '{'\
              '"name": "my_custom_field",'\
              '"type": "text"'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::ReservedFields.create_fields(hash)
      expect(actual.reserved_fields).to be_a(Array)
      actual.reserved_fields.each do |field|
        expect(field).to be_a(SendGrid4r::REST::Contacts::ReservedFields::Field)
      end
    end
  end
end
