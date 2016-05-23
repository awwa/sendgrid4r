# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns::Contacts
  describe CustomFields do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @name1 = 'birthday'
        @type1 = 'text'
        @name2 = 'born_at'
        @type2 = 'date'

        # celan up test env
        fields = @client.get_custom_fields
        fields.custom_fields.each do |field|
          next if field.name != @name1 && field.name != @name2
          @client.delete_custom_field(custom_field_id: field.id)
        end
        # post a custom field
        @new_field = @client.post_custom_field(name: @name1, type: @type1)
      end

      context 'without block call' do
        it '#post_custom_field' do
          new_field = @client.post_custom_field(name: @name2, type: @type2)
          expect(new_field.id).to be_a(Fixnum)
          expect(new_field.name).to eq(@name2)
          expect(new_field.type).to eq(@type2)
        end

        it '#post_custom_field for same key' do
          expect do
            @client.post_custom_field(name: @name1, type: @type1)
          end.to raise_error(RestClient::BadRequest)
        end

        it '#get_custom_fields' do
          fields = @client.get_custom_fields
          expect(fields.length).to be >= 1
          fields.custom_fields.each do |field|
            next if field.name != @name1
            expect(field.id).to eq(@new_field.id)
            expect(field.name).to eq(@new_field.name)
            expect(field.type).to eq(@new_field.type)
          end
        end

        it '#get_custom_field' do
          actual_field = @client.get_custom_field(
            custom_field_id: @new_field.id
          )
          expect(actual_field.id).to eq(@new_field.id)
          expect(actual_field.name).to eq(@new_field.name)
          expect(actual_field.type).to eq(@new_field.type)
        end

        it '#delete_custom_field' do
          @client.delete_custom_field(custom_field_id: @new_field.id)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:field) do
        JSON.parse(
          '{'\
            '"id": 1,'\
            '"name": "pet",'\
            '"type": "text"'\
          '}'
        )
      end

      let(:fields) do
        JSON.parse(
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
        )
      end

      it '#post_custom_field' do
        allow(client).to receive(:execute).and_return(field)
        actual = client.post_custom_field(name: '', type: '')
        expect(actual).to be_a(CustomFields::Field)
      end

      it '#get_custom_fields' do
        allow(client).to receive(:execute).and_return(fields)
        actual = client.get_custom_fields
        expect(actual).to be_a(CustomFields::Fields)
      end

      it '#get_custom_field' do
        allow(client).to receive(:execute).and_return(field)
        actual = client.get_custom_field(custom_field_id: 0)
        expect(actual).to be_a(CustomFields::Field)
      end

      it '#delete_custom_field' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_custom_field(custom_field_id: 0)
        expect(actual).to eq('')
      end

      it 'creates field instance' do
        actual = CustomFields.create_field(field)
        expect(actual).to be_a(CustomFields::Field)
        expect(actual.id).to eq(1)
        expect(actual.name).to eq('pet')
        expect(actual.type).to eq('text')
      end

      it 'creates fields instance' do
        actual = CustomFields.create_fields(fields)
        expect(actual).to be_a(CustomFields::Fields)
        expect(actual.custom_fields).to be_a(Array)
        actual.custom_fields.each do |field|
          expect(field).to be_a(CustomFields::Field)
        end
      end
    end
  end
end
