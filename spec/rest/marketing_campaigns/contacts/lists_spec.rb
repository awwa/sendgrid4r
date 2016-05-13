# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns::Contacts
  describe SendGrid4r::REST::MarketingCampaigns::Contacts::Lists do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @list_name1 = 'test_list1'
        @edit_name1 = 'test_list1_edit'
        @list_name2 = 'test_list2'
        @email1 = 'jones@example.com'
        @email2 = 'miller@example.com'
        @last_name1 = 'Jones'
        @last_name2 = 'Miller'
        @pet1 = 'Fluffy'
        @pet2 = 'FrouFrou'

        # celan up test env(lists)
        lists = @client.get_lists
        lists.lists.each do |list|
          @client.delete_list(list_id: list.id) if list.name == @list_name1
          @client.delete_list(list_id: list.id) if list.name == @edit_name1
          @client.delete_list(list_id: list.id) if list.name == @list_name2
        end
        # celan up test env(recipients)
        recipients = @client.get_recipients
        recipients.recipients.each do |recipient|
          @client.delete_recipient(
            recipient_id: recipient.id
          ) if recipient.email == @email1
          @client.delete_recipient(
            recipient_id: recipient.id
          ) if recipient.email == @email2
        end
        # post a first list
        @list1 = @client.post_list(name: @list_name1)
        # add multiple recipients
        recipient1 = {}
        recipient1['email'] = @email1
        recipient1['last_name'] = @last_name1
        recipient2 = {}
        recipient2['email'] = @email2
        recipient2['last_name'] = @last_name2
        result = @client.post_recipients(params: [recipient1, recipient2])
        @recipients = result.persisted_recipients
        @client.post_recipient_to_list(
          list_id: @list1.id, recipient_id: result.persisted_recipients[0]
        )
        @client.post_recipient_to_list(
          list_id: @list1.id, recipient_id: result.persisted_recipients[1]
        )
      end

      context 'without block call' do
        it '#post_list' do
          list2 = @client.post_list(name: @list_name2)
          expect(list2.id).to be_a(Fixnum)
          expect(list2.name).to eq(@list_name2)
          expect(list2.recipient_count).to eq(0)
          @client.delete_list(list_id: list2.id)
        end

        it '#post_list for same key' do
          expect do
            @client.post_list(name: @list_name1)
          end.to raise_error(RestClient::BadRequest)
        end

        it '#get_lists' do
          lists = @client.get_lists
          expect(lists.length).to be >= 1
          lists.lists.each do |list|
            next if list.name != @list_name1
            expect(list.id).to eq(@list1.id)
            expect(list.name).to eq(@list1.name)
            expect(list.recipient_count).to be_a(Fixnum)
          end
        end

        it '#get_list' do
          actual_list = @client.get_list(list_id: @list1.id)
          expect(actual_list.id).to eq(@list1.id)
          expect(actual_list.name).to eq(@list1.name)
          expect(actual_list.recipient_count).to be_a(Fixnum)
        end

        it '#patch_list' do
          edit_list = @client.patch_list(list_id: @list1.id, name: @edit_name1)
          expect(edit_list.id).to eq(@list1.id)
          expect(edit_list.name).to eq(@edit_name1)
        end

        it '#get_recipients_from_list' do
          recipients = @client.get_recipients_from_list(list_id: @list1.id)
          recipients.recipients.each do |recipient|
            expect(recipient).to be_a(Recipients::Recipient)
          end
        end

        it '#get_recipients_from_list with offset & limit' do
          recipients = @client.get_recipients_from_list(
            list_id: @list1.id, page: 1, page_size: 10
          )
          recipients.recipients.each do |recipient|
            expect(recipient).to be_a(Recipients::Recipient)
          end
        end

        it '#delete_recipient_from_list' do
          @client.delete_recipient_from_list(
            list_id: @list1.id, recipient_id: @recipients[0]
          )
        end

        it '#delete_list' do
          @client.delete_list(list_id: @list1.id)
          expect do
            @client.get_list(list_id: @list1.id)
          end.to raise_error(RestClient::ResourceNotFound)
        end

        it '#delete_lists' do
          list2 = @client.post_list(name: @list_name2)
          @client.delete_lists(list_ids: [@list1.id, list2.id])
        end

        it '#post_recipients_to_list' do
          @client.post_recipients_to_list(
            list_id: @list1.id, recipients: @recipients
          )
        end

        it '#post_recipient_to_list' do
          recipient1 = {}
          recipient1['email'] = @email1
          recipient1['last_name'] = @last_name1
          result = @client.post_recipients(params: [recipient1])
          @client.post_recipient_to_list(
            list_id: @list1.id, recipient_id: result.persisted_recipients[0]
          )
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:list) do
        JSON.parse(
          '{'\
            '"id": 1,'\
            '"name": "listname",'\
            '"recipient_count": 0'\
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

      let(:recipient) do
        JSON.parse(
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
        )
      end

      it '#post_list' do
        allow(client).to receive(:execute).and_return(list)
        actual = client.post_list(name: '')
        expect(actual).to be_a(Lists::List)
      end

      it '#get_lists' do
        allow(client).to receive(:execute).and_return(lists)
        actual = client.get_lists
        expect(actual).to be_a(Lists::Lists)
      end

      it '#get_list' do
        allow(client).to receive(:execute).and_return(list)
        actual = client.get_list(list_id: 0)
        expect(actual).to be_a(Lists::List)
      end

      it '#patch_list' do
        allow(client).to receive(:execute).and_return(list)
        actual = client.patch_list(list_id: 0, name: '')
        expect(actual).to be_a(Lists::List)
      end

      it '#get_recipients_from_list' do
        allow(client).to receive(:execute).and_return(recipients)
        actual = client.get_recipients_from_list(list_id: 0)
        expect(actual).to be_a(Recipients::Recipients)
      end

      it '#delete_recipient_from_list' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_recipient_from_list(list_id: 0, recipient_id: '')
        expect(actual).to eq('')
      end

      it '#delete_list' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_list(list_id: 0)
        expect(actual).to eq('')
      end

      it '#delete_lists' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_lists(list_ids: [0, 1])
        expect(actual).to eq('')
      end

      it '#post_recipients_to_list' do
        allow(client).to receive(:execute).and_return('')
        actual = client.post_recipients_to_list(
          list_id: 0, recipients: ['', '']
        )
        expect(actual).to eq('')
      end

      it '#post_recipient_to_list' do
        allow(client).to receive(:execute).and_return('')
        actual = client.post_recipient_to_list(list_id: 0, recipient_id: 0)
        expect(actual).to eq('')
      end

      it 'creates list instance' do
        actual = Lists.create_list(list)
        expect(actual).to be_a(Lists::List)
        expect(actual.id).to eq(1)
        expect(actual.name).to eq('listname')
        expect(actual.recipient_count).to eq(0)
      end

      it 'creates lists instance' do
        actual = Lists.create_lists(lists)
        expect(actual.lists).to be_a(Array)
        actual.lists.each do |list|
          expect(list).to be_a(Lists::List)
        end
      end
    end
  end
end
