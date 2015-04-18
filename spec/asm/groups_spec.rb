# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Asm::Groups do
  before do
    begin
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
      @group_name1 = 'group_test1'
      @group_name2 = 'group_test2'
      @group_name_edit1 = 'group_edit1'
      @group_desc = 'group_desc'
      @group_desc_edit = 'group_desc_edit'

      # celan up test env
      grps = @client.get_groups
      expect(grps.length >= 0).to eq(true)
      grps.each do |grp|
        @client.delete_group(grp.id) if grp.name == @group_name1
        @client.delete_group(grp.id) if grp.name == @group_edit1
        @client.delete_group(grp.id) if grp.name == @group_name2
      end
      # post a group
      @group1 = @client.post_group(@group_name1, @group_desc)
    rescue => e
      puts e.inspect
      raise e
    end
  end

  context 'without block call' do
    it '#post_group' do
      begin
        group2 = @client.post_group(@group_name2, @group_desc)
        expect(@group_name2).to eq(group2.name)
        expect(@group_desc).to eq(group2.description)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#patch_group' do
      begin
        @group1.name = @group_name_edit1
        @group1.description = @group_desc_edit
        group_edit1 = @client.patch_group(@group1.id, @group1)
        expect(group_edit1.id).to be_a(Fixnum)
        expect(group_edit1.name).to eq(@group_name_edit1)
        expect(group_edit1.description).to eq(@group_desc_edit)
        expect(group_edit1.last_email_sent_at).to eq(nil)
        expect(group_edit1.unsubscribes).to eq(nil)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_groups' do
      begin
        groups = @client.get_groups
        expect(groups).to be_a(Array)
        groups.each do |group|
          expect(group).to be_a(SendGrid4r::REST::Asm::Groups::Group)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_group' do
      begin
        group = @client.get_group(@group1.id)
        expect(group.id).to be_a(Fixnum)
        expect(group.name).to eq(@group_name1)
        expect(group.description).to eq(@group_desc)
        expect(group.last_email_sent_at).to eq(nil)
        expect(group.unsubscribes).to eq(0)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_group' do
      begin
        @client.delete_group(@group1.id)
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    it '#post_group' do
      @client.post_group(@group_name2, @group_desc) do |resp, req, res|
        resp =
          SendGrid4r::REST::Asm::Groups.create_group(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Asm::Groups::Group)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end

    it '#patch_group' do
      @client.patch_group(@group1.id, @group1) do |resp, req, res|
        resp =
          SendGrid4r::REST::Asm::Groups.create_group(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Asm::Groups::Group)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_group' do
      @client.get_group(@group1.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Asm::Groups.create_group(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Asm::Groups::Group)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#delete_group' do
      @client.delete_group(@group1.id) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end
  end

  context 'unit test' do
    it 'creates group instance' do
      json =
        '{'\
          '"id": 100,'\
          '"name": "Newsletters",'\
          '"description": "Our monthly newsletter.",'\
          '"last_email_sent_at": "2014-09-04 01:34:43",'\
          '"unsubscribes": 400'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Asm::Groups.create_group(hash)
      expect(actual).to be_a(
        SendGrid4r::REST::Asm::Groups::Group
      )
    end
  end
end
