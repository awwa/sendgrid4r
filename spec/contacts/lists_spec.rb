# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Lists' do
  context 'it test' do
    before :all do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
      @list_name1 = 'test_list1'
      @edit_name1 = 'test_list1_edit'
      @list_name2 = 'test_list2'
      @email1 = 'jones@example.com'
      @email2 = 'miller@example.com'
      @last_name1 = 'Jones'
      @last_name2 = 'Miller'
      @pet1 = 'Fluffy'
      @pet2 = 'FrouFrou'
      @custom_field_name = 'pet'
      @recipients = [@email1, @email2]
    end

    it 'is normal' do
      begin
        # celan up test env(lists)
        lists = @client.get_lists
        expect(lists.lists.length >= 0).to eq(true)
        lists.lists.each do |list|
          @client.delete_list(list.id) if list.name == @list_name1
          @client.delete_list(list.id) if list.name == @edit_name1
          @client.delete_list(list.id) if list.name == @list_name2
        end
        # celan up test env(recipients)
        recipients = @client.get_recipients
        expect(recipients.recipients.length >= 0).to eq(true)
        recipients.recipients.each do |recipient|
          @client.delete_recipient(recipient.id) if recipient.email == @email1
          @client.delete_recipient(recipient.id) if recipient.email == @email2
        end
        # post a first list
        new_list = @client.post_list(@list_name1)
        expect(new_list.id.is_a?(Fixnum)).to eq(true)
        expect(new_list.name).to eq(@list_name1)
        expect(new_list.recipient_count).to eq(0)
        # post same list
        expect do
          @client.post_list(@list_name1)
        end.to raise_error(RestClient::BadRequest)
        # get all list
        lists = @client.get_lists
        expect(lists.length >= 1).to eq(true)
        lists.lists.each do |list|
          next if list.name != @list_name1
          expect(list.id).to eq(new_list.id)
          expect(list.name).to eq(new_list.name)
          expect(list.recipient_count).to eq(0)
        end
        # get a single list
        actual_list = @client.get_list(new_list.id)
        expect(actual_list.id).to eq(new_list.id)
        expect(actual_list.name).to eq(new_list.name)
        expect(actual_list.recipient_count).to eq(0)
        # update the list
        edit_list = @client.patch_list(new_list.id, @edit_name1)
        expect(edit_list.id).to eq(new_list.id)
        expect(edit_list.name).to eq(@edit_name1)
        # add multiple recipients
        recipient1 = {}
        recipient1['email'] = @email1
        recipient1['last_name'] = @last_name1
        recipient1[@custom_field_name] = @pet1
        @client.post_recipient(recipient1)
        recipient2 = {}
        recipient2['email'] = @email2
        recipient2['last_name'] = @last_name2
        recipient2[@custom_field_name] = @pet2
        @client.post_recipient(recipient2)
        # Add multiple recipients to a single list
        @client.post_recipients_to_list(edit_list.id, @recipients)
        # list recipients from a single list
        recipients = @client.get_recipients_from_list(new_list.id)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
          ).to eq(true)
        end
        # list recipients from a single list with offset & limit
        recipients = @client.get_recipients_from_list(new_list.id, 10, 0)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
          ).to eq(true)
        end
        # Add single recipient to a list
        @client.post_recipient_to_list(edit_list.id, @email1)
        # get a single list
        actual_list = @client.get_list(new_list.id)
        expect(actual_list.recipient_count).to eq(2)
        # delete a single recipient from a single list
        # This
        @client.delete_recipient_from_list(edit_list.id, @email1)
        # delete the list
        @client.delete_list(new_list.id)
        expect do
          @client.get_list(new_list.id)
        end.to raise_error(RestClient::ResourceNotFound)
        # post 2 lists
        list1 = @client.post_list(@list_name1)
        list2 = @client.post_list(@list_name2)
        @client.delete_lists([list1.id,list2.id])
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'unit test' do
    it 'creates list instance' do
      json =
        '{'\
          '"id": 1,'\
          '"name": "listname",'\
          '"recipient_count": 0'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Lists.create_list(hash)
      expect(actual.id).to eq(1)
      expect(actual.name).to eq('listname')
      expect(actual.recipient_count).to eq(0)
    end

    it 'creates lists instance' do
      json =
        '{'\
          '"lists": ['\
            '{'\
              '"id": 1,'\
              '"name": "the jones",'\
              '"recipient_count": 1'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Lists.create_lists(hash)
      expect(actual.lists.is_a?(Array)).to eq(true)
      actual.lists.each do |list|
        expect(
          list.is_a?(SendGrid4r::REST::Contacts::Lists::List)
        ).to eq(true)
      end
    end
  end
end
