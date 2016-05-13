# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns::Contacts
  describe ReservedFields do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @first_name = ReservedFields::Field.new('first_name', 'text')
        @last_name = ReservedFields::Field.new('last_name', 'text')
        @email = ReservedFields::Field.new('email', 'text')
        @created_at = ReservedFields::Field.new('created_at', 'date')
        @updated_at = ReservedFields::Field.new('updated_at', 'date')
        @last_emailed = ReservedFields::Field.new('last_emailed', 'date')
        @last_clicked = ReservedFields::Field.new('last_clicked', 'date')
        @last_opened = ReservedFields::Field.new('last_opened', 'date')
      end

      context 'without block call' do
        it '#get_reserved_fields' do
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
            '"name": "first_name",'\
            '"type": "text"'\
          '}'
        )
      end

      let(:fields) do
        JSON.parse(
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
        )
      end

      it '#get_reserved_fields' do
        allow(client).to receive(:execute).and_return(fields)
        actual = client.get_reserved_fields
        expect(actual).to be_a(ReservedFields::Fields)
      end

      it 'creates field instance' do
        actual = CustomFields.create_field(field)
        expect(actual.name).to eq('first_name')
        expect(actual.type).to eq('text')
      end

      it 'creates fields instance' do
        actual = ReservedFields.create_fields(fields)
        expect(actual).to be_a(ReservedFields::Fields)
        expect(actual.reserved_fields).to be_a(Array)
        actual.reserved_fields.each do |field|
          expect(field).to be_a(ReservedFields::Field)
        end
      end
    end
  end
end
