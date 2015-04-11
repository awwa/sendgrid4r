# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Lists' do
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

  context 'without block call' do
    before :all do
      # celan up test env(lists)
      lists = @client.get_lists
      lists.lists.each do |list|
        @client.delete_list(list.id) if list.name == @list_name1
        @client.delete_list(list.id) if list.name == @edit_name1
        @client.delete_list(list.id) if list.name == @list_name2
      end
      # celan up test env(recipients)
      recipients = @client.get_recipients
      recipients.recipients.each do |recipient|
        @client.delete_recipient(recipient.id) if recipient.email == @email1
        @client.delete_recipient(recipient.id) if recipient.email == @email2
      end
      # post a first list
      @list1 = @client.post_list(@list_name1)
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
      @client.post_recipients_to_list(@list1.id, @recipients)
    end

    it 'post_list' do
      begin
        list2 = @client.post_list(@list_name2)
        expect(list2.id).to be_a(Fixnum)
        expect(list2.name).to eq(@list_name2)
        expect(list2.recipient_count).to eq(0)
        @client.delete_list(list2.id)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'post_list for same key' do
      begin
        expect do
          @client.post_list(@list_name1)
        end.to raise_error(RestClient::BadRequest)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'get_lists' do
      begin
        lists = @client.get_lists
        expect(lists.length).to be >= 1
        lists.lists.each do |list|
          next if list.name != @list_name1
          expect(list.id).to eq(@list1.id)
          expect(list.name).to eq(@list1.name)
          expect(list.recipient_count).to eq(2)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'get_list' do
      begin
        actual_list = @client.get_list(@list1.id)
        expect(actual_list.id).to eq(@list1.id)
        expect(actual_list.name).to eq(@list1.name)
        expect(actual_list.recipient_count).to eq(2)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'patch_list' do
      begin
        edit_list = @client.patch_list(@list1.id, @edit_name1)
        expect(edit_list.id).to eq(@list1.id)
        expect(edit_list.name).to eq(@edit_name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'get_recipients_from_list' do
      begin
        recipients = @client.get_recipients_from_list(@list1.id)
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

    it 'get_recipients_from_list with offset & limit' do
      begin
        recipients = @client.get_recipients_from_list(@list1.id, 10, 0)
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

    it 'delete_recipient_from_list' do
      begin
        @client.delete_recipient_from_list(@list1.id, @email1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'delete_list' do
      begin
        @client.delete_list(@list1.id)
        expect do
          @client.get_list(@list1.id)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'delete_lists' do
      begin
        list2 = @client.post_list(@list_name2)
        @client.delete_lists([@list1.id, list2.id])
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    before :all do
      # celan up test env(lists)
      lists = @client.get_lists
      lists.lists.each do |list|
        @client.delete_list(list.id) if list.name == @list_name1
        @client.delete_list(list.id) if list.name == @edit_name1
        @client.delete_list(list.id) if list.name == @list_name2
      end
      # celan up test env(recipients)
      recipients = @client.get_recipients
      recipients.recipients.each do |recipient|
        @client.delete_recipient(recipient.id) if recipient.email == @email1
        @client.delete_recipient(recipient.id) if recipient.email == @email2
      end
      # post a first list
      @list1 = @client.post_list(@list_name1)
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
      @client.post_recipients_to_list(@list1.id, @recipients)
    end

    it 'post_list' do
      @client.post_list(@list_name2) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Lists.create_list(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Lists::List)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end

    it 'post_list for same key' do
      @client.post_list(@list_name1) do |_resp, req, res|
        # TODO: _resp
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPBadRequest)
      end
    end

    it 'get_lists' do
      @client.get_lists do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Lists.create_lists(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Lists::Lists)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it 'get_list' do
      @client.get_list(@list1.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Lists.create_list(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Lists::List)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it 'patch_list' do
      @client.patch_list(@list1.id, @edit_name1) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Lists.create_list(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Lists::List)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it 'get_recipients_from_list' do
      @client.get_recipients_from_list(@list1.id) do | resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it 'get_recipients_from_list with offset & limit' do
      @client.get_recipients_from_list(@list1.id, 10, 0) do | resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it 'delete_recipient_from_list' do
      @client.delete_recipient_from_list(@list1.id, @email1) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end

    it 'delete_list' do
      @client.delete_list(@list1.id) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end

    it 'delete_lists' do
      @client.delete_lists([@list1.id]) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
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
      expect(actual.lists).to be_a(Array)
      actual.lists.each do |list|
        expect(list).to be_a(SendGrid4r::REST::Contacts::Lists::List)
      end
    end
  end
end
