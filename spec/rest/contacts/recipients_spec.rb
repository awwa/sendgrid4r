# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Contacts::Recipients do
  describe 'integration test', :it do
    before do
      begin
        pending 'waiting sendgrid documentation update'
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
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
          @client.delete_recipient(recipient_id: recipient.id)
        end
        custom_fields = @client.get_custom_fields
        custom_fields.custom_fields.each do |custom_field|
          next if custom_field.name != @custom_field_name
          @client.delete_custom_field(custom_field_id: custom_field.id)
        end
        @client.post_custom_field(name: @custom_field_name, type: 'text')
        # post a recipient
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        @new_recipient = @client.post_recipient(params: params)
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
          new_recipient = @client.post_recipient(params: params)
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
          @client.post_recipient(params: params)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_recipients' do
        begin
          recipients = @client.get_recipients(limit: 100, offset: 0)
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
          recipients = @client.search_recipients(params: params)
          expect(recipients.recipients).to be_a(Array)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_recipient' do
        begin
          recipient = @client.get_recipient(recipient_id: @new_recipient.id)
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
          lists = @client.get_lists_recipient_belong(
            recipient_id: @new_recipient.id
          )
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
          result = @client.post_recipients(params: params)
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
          actual_recipients = @client.get_recipients_by_id(
            recipient_ids: recipient_ids
          )
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
          @client.delete_recipient(recipient_id: @new_recipient.id)
          expect do
            @client.get_recipient(recipient_id: @new_recipient.id)
          end.to raise_error(RestClient::ResourceNotFound)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_recipients' do
        begin
          @client.delete_recipients(emails: [@email1, @email2])
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
        @client.post_recipient(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Recipients.create_recipient(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipient
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#delete_recipient' do
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        recipient = @client.post_recipient(params: params)
        @client.delete_recipient(recipient_id: recipient.id) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end

      it '#delete_recipients' do
        @client.delete_recipients(
          emails: [@email1, @email2]
        ) do |resp, req, res|
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
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipients
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_recipients_by_id' do
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        recipient = @client.post_recipient(params: params)
        @client.get_recipients_by_id(
          recipient_ids: [recipient.id]
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Recipients.create_recipients(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipients
          )
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
        @client.search_recipients(params: params) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Recipients.create_recipients(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipients
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_recipient' do
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        recipient = @client.post_recipient(params: params)
        @client.get_recipient(recipient.id) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Recipients.create_recipient(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipient
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_lists_recipient_belong' do
        params = {}
        params['email'] = @email1
        params['last_name'] = @last_name1
        params[@custom_field_name] = @pet1
        recipient = @client.post_recipient(params: params)
        @client.get_lists_recipient_belong(
          recipient_id: recipient.id
        ) do |resp, req, res|
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
        @client.post_recipients(params: params) do |resp, req, res|
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
          '"error_count": 0,'\
          '"error_indices": ['\
          '],'\
          '"new_count": 2,'\
          '"persisted_recipients": ['\
            '"jones@example.com",'\
            '"miller@example.com"'\
          '],'\
          '"updated_count": 0'\
        '}'
      )
    end

    it '#post_recipient' do
      allow(client).to receive(:execute).and_return(recipient)
      actual = client.post_recipient(params: {})
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
    end

    it '#get_recipients' do
      allow(client).to receive(:execute).and_return(recipients)
      actual = client.get_recipients(limit: 0, offset: 0)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
    end

    it '#get_recipient_count' do
      allow(client).to receive(:execute).and_return(recipient_count)
      actual = client.get_recipients_count
      expect(actual).to be_a(Fixnum)
    end

    it '#search_recipients' do
      allow(client).to receive(:execute).and_return(recipients)
      actual = client.search_recipients(params: {})
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
    end

    it '#get_recipient' do
      allow(client).to receive(:execute).and_return(recipient)
      actual = client.get_recipient(recipient_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
    end

    it '#get_lists_recipient_belong' do
      allow(client).to receive(:execute).and_return(lists)
      actual = client.get_lists_recipient_belong(recipient_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Lists::Lists)
    end

    it '#post_recipients' do
      allow(client).to receive(:execute).and_return(result)
      actual = client.post_recipients(recipients: [{}, {}])
      expect(actual).to be_a(
        SendGrid4r::REST::Contacts::Recipients::ResultAddMultiple
      )
    end

    it '#get_recipients_by_id' do
      allow(client).to receive(:execute).and_return(recipients)
      actual = client.get_recipients_by_id(recipient_ids: ['', ''])
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
    end

    it '#delete_recipient' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_recipient(recipient_id: 0)
      expect(actual).to eq('')
    end

    it '#delete_recipients' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_recipients(emails: ['', ''])
      expect(actual).to eq('')
    end

    it 'creates recipient instance' do
      actual = SendGrid4r::REST::Contacts::Recipients.create_recipient(
        recipient
      )
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
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
      actual = SendGrid4r::REST::Contacts::Recipients.create_recipients(
        recipients
      )
      expect(actual.recipients).to be_a(Array)
      actual.recipients.each do |recipient|
        expect(
          recipient
        ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
      end
    end
  end
end
