# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Lists' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    @name = 'test_list'
    @edit_name = 'test_list_edit'
    @recipients = ['jones@example.com', 'miller@example.com']
  end

  context 'always' do
    it 'is normal' do
      begin
        # celan up test env
        lists = @client.get_lists
        expect(lists.lists.length >= 0).to eq(true)
        lists.lists.each do |list|
          next if list.name != @name && list.name != @edit_name
          @client.delete_list(list.id)
        end
        # post a list
        new_list = @client.post_list(@name)
        expect(new_list.id.is_a?(Fixnum)).to eq(true)
        expect(new_list.name).to eq(@name)
        expect(new_list.recipient_count).to eq(0)
        # post same lists
        expect do
          @client.post_list(@name)
        end.to raise_error(RestClient::BadRequest)
        # get all list
        lists = @client.get_lists
        expect(lists.length >= 1).to eq(true)
        lists.lists.each do |list|
          next if list.name != @name
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
        edit_list = @client.patch_list(new_list.id, @edit_name)
        expect(edit_list.id).to eq(new_list.id)
        expect(edit_list.name).to eq(@edit_name)
        # TODO: expect(edit_list.recipient_count).to eq(0)
        # Add multiple recipients to a single list
        # @client.post_recipients_to_list(edit_list.id, @recipients)
        # add_list = @client.get_list(new_list.id)
        # expect(add_list.recipient_ount).to eq(2)
        # list recipients from a single list
        recipients = @client.get_recipients_from_list(new_list.id)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?
          ).to eq(SendGrid4r::REST::Contacts::Recipients::Recipients)
        end
        # list recipients from a single list with offset & limit
        recipients = @client.get_recipients_from_list(new_list.id, 10, 0)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?
          ).to eq(SendGrid4r::REST::Contacts::Recipients::Recipients)
        end
        # Add single recipient to a list
        # TODO
        # delete a single recipient from a single list
        # TODO
        # delete the list
        @client.delete_list(new_list.id)
        expect do
          @client.get_list(new_list.id)
        end.to raise_error(RestClient::ResourceNotFound)

      rescue => e
        puts e.inspect
        raise e
      end
    end

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
