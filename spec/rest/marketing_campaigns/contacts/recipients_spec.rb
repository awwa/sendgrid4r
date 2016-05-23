# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns::Contacts
  describe Recipients do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @email1 = 'jones@example.com'
        @email2 = 'miller@example.com'
        @email3 = 'jones...example.com'
        @last_name1 = 'Jones'
        @last_name2 = 'Miller'
        @last_name3 = 'Invalid'
        @pet1 = 'Fluffy'
        @pet2 = 'FrouFrou'

        # celan up test env
        recipients = @client.get_recipients
        recipients.recipients.each do |recipient|
          next if recipient.email != @email1 && recipient.email != @email2
          @client.delete_recipient(recipient_id: recipient.id)
        end
        # post a recipient
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        @result = @client.post_recipients(params: [params])
      end

      context 'without block call' do
        it '#post_recipients' do
          params = {}
          params['email'] = @email2
          params['last_name'] = @last_name2
          result = @client.post_recipients(params: [params])
          expect(result.error_count).to eq(0)
          expect(result.error_indices).to eq([])
          expect(result.new_count).to eq(1)
          expect(result.persisted_recipients).to be_a(Array)
          expect(result.updated_count).to eq(0)
        end

        it '#post_recipients with error' do
          params = {}
          params['email'] = @email3
          params['last_name'] = @last_name3
          result = @client.post_recipients(params: [params])
          expect(result.error_count).to eq(1)
          expect(result.error_indices).to eq([0])
          expect(result.errors).to be_a(Array)
          result.errors.each do |error|
            expect(error.error_indices).to be_a(Array)
            expect(error.message).to be_a(String)
          end
          expect(result.new_count).to eq(0)
          expect(result.persisted_recipients).to be_a(Array)
          expect(result.updated_count).to eq(0)
        end

        it '#patch_recipients' do
          params = {}
          params['email'] = @email1
          params['last_name'] = 'JonesEdit'
          result = @client.patch_recipients(params: [params])
          expect(result.error_count).to eq(0)
          expect(result.error_indices).to eq([])
          expect(result.new_count).to eq(0)
          expect(result.persisted_recipients).to be_a(Array)
          expect(result.updated_count).to eq(1)
        end

        it '#delete_recipients' do
          @client.delete_recipients(recipient_ids: @result.persisted_recipients)
        end

        it '#get_recipients' do
          recipients = @client.get_recipients(page: 1, page_size: 100)
          expect(recipients.recipients.length).to be > 0
          recipients.recipients.each do |recipient|
            expect(recipient).to be_a(Recipients::Recipient)
          end
        end

        it '#get_recipient' do
          recipient = @client.get_recipient(
            recipient_id: @result.persisted_recipients[0]
          )
          expect(recipient).to be_a(Recipients::Recipient)
        end

        it '#delete_recipient' do
          @client.delete_recipient(
            recipient_id: @result.persisted_recipients[0]
          )
          expect do
            @client.get_recipient(recipient_id: @result.persisted_recipients[0])
          end.to raise_error(RestClient::ResourceNotFound)
        end

        it '#get_lists_recipient_belong' do
          lists = @client.get_lists_recipient_belong(
            recipient_id: @result.persisted_recipients[0]
          )
          lists.lists.each do |list|
            expect(list.is_a?(Lists::List)).to eq(true)
          end
        end

        it '#get_recipient_count' do
          actual_count = @client.get_recipients_count
          expect(actual_count).to be >= 0
        end

        it '#search_recipients' do
          params = {}
          params['email'] = @email1
          recipients = @client.search_recipients(params: params)
          expect(recipients.recipients).to be_a(Array)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:recipient) do
        JSON.parse(
          '{'\
            '"created_at": 1422313607,'\
            '"email": "jones@example.com",'\
            '"first_name": null,'\
            '"id": "YUBh",'\
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
        )
      end

      let(:recipients) do
        JSON.parse(
          '{'\
            '"recipients": ['\
              '{'\
                '"created_at": 1422313607,'\
                '"email": "jones@example.com",'\
                '"first_name": null,'\
                '"id": "YUBh",'\
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
        )
      end

      let(:recipient_count) do
        JSON.parse(
          '{'\
            '"recipient_count": 2'\
          '}'
        )
      end

      let(:lists) do
        JSON.parse(
          '{'\
            '"lists": ['\
              '{'\
                '"id": 1,'\
                '"name": "the jones",'\
                '"recipient_count": 1'\
              '}'\
            ']'\
          '}'
        )
      end

      let(:result) do
        JSON.parse(
          '{'\
            '"error_count": 1,'\
            '"error_indices": ['\
              '2'\
            '],'\
            '"new_count": 2,'\
            '"persisted_recipients": ['\
              '"YUBh",'\
              '"bWlsbGVyQG1pbGxlci50ZXN0"'\
            '],'\
            '"updated_count": 0,'\
            '"errors": ['\
              '{'\
                '"message": "Invalid email.",'\
                '"error_indices": ['\
                  '2'\
                ']'\
              '}'\
            ']'\
          '}'
        )
      end

      it '#post_recipients' do
        allow(client).to receive(:execute).and_return(result)
        actual = client.post_recipients(params: {})
        expect(actual).to be_a(Recipients::Result)
      end

      it '#patch_recipients' do
        allow(client).to receive(:execute).and_return(result)
        actual = client.patch_recipients(params: {})
        expect(actual).to be_a(Recipients::Result)
      end

      it '#delete_recipients' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_recipients(recipient_ids: ['', ''])
        expect(actual).to eq('')
      end

      it '#get_recipients' do
        allow(client).to receive(:execute).and_return(recipients)
        actual = client.get_recipients(page: 0, page_size: 0)
        expect(actual).to be_a(Recipients::Recipients)
      end

      it '#get_recipient' do
        allow(client).to receive(:execute).and_return(recipient)
        actual = client.get_recipient(recipient_id: '')
        expect(actual).to be_a(Recipients::Recipient)
      end

      it '#delete_recipient' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_recipient(recipient_id: '')
        expect(actual).to eq('')
      end

      it '#get_lists_recipient_belong' do
        allow(client).to receive(:execute).and_return(lists)
        actual = client.get_lists_recipient_belong(recipient_id: '')
        expect(actual).to be_a(Lists::Lists)
      end

      it '#get_recipient_count' do
        allow(client).to receive(:execute).and_return(recipient_count)
        actual = client.get_recipients_count
        expect(actual).to be_a(Fixnum)
      end

      it '#search_recipients' do
        allow(client).to receive(:execute).and_return(recipients)
        actual = client.search_recipients(params: {})
        expect(actual).to be_a(Recipients::Recipients)
      end

      it 'creates recipient instance' do
        actual = Recipients.create_recipient(
          recipient
        )
        expect(actual).to be_a(Recipients::Recipient)
        expect(actual.created_at).to eq(Time.at(1422313607))
        expect(actual.email).to eq('jones@example.com')
        expect(actual.first_name).to eq(nil)
        expect(actual.id).to eq('YUBh')
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
        actual = Recipients.create_recipients(recipients)
        expect(actual.recipients).to be_a(Array)
        actual.recipients.each do |recipient|
          expect(recipient).to be_a(Recipients::Recipient)
        end
      end

      it 'creates result instance' do
        actual = Recipients.create_result(result)
        expect(actual.error_count).to eq(1)
        expect(actual.error_indices).to be_a(Array)
        expect(actual.error_indices[0]).to eq(2)
        expect(actual.new_count).to eq(2)
        expect(actual.persisted_recipients).to be_a(Array)
        expect(actual.persisted_recipients[0]).to eq('YUBh')
        expect(actual.persisted_recipients[1]).to eq(
          'bWlsbGVyQG1pbGxlci50ZXN0'
        )
        expect(actual.updated_count).to eq(0)
        expect(actual.errors).to be_a(Array)
        expect(actual.errors[0].message).to eq('Invalid email.')
        expect(actual.error_indices).to be_a(Array)
        expect(actual.error_indices[0]).to eq(2)
      end
    end
  end
end
