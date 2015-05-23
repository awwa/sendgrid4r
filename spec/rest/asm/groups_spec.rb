# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Asm::Groups do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          username: ENV['SENDGRID_USERNAME'],
          password: ENV['SENDGRID_PASSWORD'])
        @group_name1 = 'group_test1'
        @group_name2 = 'group_test2'
        @group_name_edit1 = 'group_edit1'
        @group_desc = 'group_desc'
        @group_desc_edit = 'group_desc_edit'

        # celan up test env
        grps = @client.get_groups
        grps.each do |grp|
          @client.delete_group(grp.id) if grp.name == @group_name1
          @client.delete_group(grp.id) if grp.name == @group_name_edit1
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

      it '#get_groups' do
        @client.get_groups do |resp, req, res|
          resp =
            SendGrid4r::REST::Asm::Groups.create_groups(
              JSON.parse(resp)
            )
          expect(resp).to be_a(Array)
          resp.each do |group|
            expect(group).to be_a(SendGrid4r::REST::Asm::Groups::Group)
          end
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
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:group) do
      JSON.parse(
        '{'\
          '"id": 100,'\
          '"name": "Newsletters",'\
          '"description": "Our monthly newsletter.",'\
          '"last_email_sent_at": "2014-09-04 01:34:43",'\
          '"unsubscribes": 400'\
        '}'
      )
    end

    let(:groups) do
      JSON.parse(
        '['\
          '{'\
            '"id": 100,'\
            '"name": "Newsletters",'\
            '"description": "Our monthly newsletter.",'\
            '"last_email_sent_at": "2014-09-04 01:34:43",'\
            '"unsubscribes": 400'\
          '},'\
          '{'\
            '"id": 101,'\
            '"name": "Alerts",'\
            '"description": "Emails triggered by user-defined rules.",'\
            '"last_email_sent_at": "2012-11-06 09:37:33",'\
            '"unsubscribes": 1'\
          '}'\
        ']'
      )
    end

    it '#post_group' do
      allow(client).to receive(:execute).and_return(group)
      actual = client.post_group('', '')
      expect(actual).to be_a(SendGrid4r::REST::Asm::Groups::Group)
    end

    it '#patch_group' do
      allow(client).to receive(:execute).and_return(group)
      actual = client.patch_group(0, nil)
      expect(actual).to be_a(SendGrid4r::REST::Asm::Groups::Group)
    end

    it '#get_groups' do
      allow(client).to receive(:execute).and_return(groups)
      actual = client.get_groups
      expect(actual).to be_a(Array)
      actual.each do |group|
        expect(group).to be_a(SendGrid4r::REST::Asm::Groups::Group)
      end
    end

    it '#get_group' do
      allow(client).to receive(:execute).and_return(group)
      actual = client.get_group(0)
      expect(actual).to be_a(SendGrid4r::REST::Asm::Groups::Group)
    end

    it '#delete_group' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_group(0)
      expect(actual).to eq('')
    end

    it 'creates group instance' do
      actual = SendGrid4r::REST::Asm::Groups.create_group(group)
      expect(actual).to be_a(
        SendGrid4r::REST::Asm::Groups::Group
      )
      expect(actual.id).to eq(100)
      expect(actual.name).to eq('Newsletters')
      expect(actual.description).to eq('Our monthly newsletter.')
      expect(actual.last_email_sent_at).to eq('2014-09-04 01:34:43')
      expect(actual.unsubscribes).to eq(400)
    end

    it 'creates groups instance' do
      actual = SendGrid4r::REST::Asm::Groups.create_groups(groups)
      expect(actual).to be_a(Array)
      actual.each do |group|
        expect(group).to be_a(SendGrid4r::REST::Asm::Groups::Group)
      end
    end
  end
end
