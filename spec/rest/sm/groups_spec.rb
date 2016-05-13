# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Sm
  describe SendGrid4r::REST::Sm::Groups do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @group_name1 = 'group_test1'
        @group_name2 = 'group_test2'
        @group_name_edit1 = 'group_edit1'
        @group_desc = 'group_desc'
        @group_desc_edit = 'group_desc_edit'

        # celan up test env
        grps = @client.get_groups
        grps.each do |grp|
          @client.delete_group(
            group_id: grp.id
          ) if grp.name == @group_name1
          @client.delete_group(
            group_id: grp.id
          ) if grp.name == @group_name_edit1
          @client.delete_group(
            group_id: grp.id
          ) if grp.name == @group_name2
        end
        # post a group
        @group1 = @client.post_group(
          name: @group_name1, description: @group_desc
        )
      end

      context 'without block call' do
        it '#post_group' do
          group2 = @client.post_group(
            name: @group_name2, description: @group_desc
          )
          expect(@group_name2).to eq(group2.name)
          expect(@group_desc).to eq(group2.description)
        end

        it '#post_group with is_default' do
          group2 = @client.post_group(
            name: @group_name2, description: @group_desc, is_default: false
          )
          expect(@group_name2).to eq(group2.name)
          expect(@group_desc).to eq(group2.description)
          expect(false).to eq(group2.is_default)
        end

        it '#get_groups' do
          groups = @client.get_groups
          expect(groups).to be_a(Array)
          groups.each do |group|
            expect(group).to be_a(Groups::Group)
          end
        end

        it '#get_group' do
          group = @client.get_group(group_id: @group1.id)
          expect(group.id).to be_a(Fixnum)
          expect(group.name).to eq(@group_name1)
          expect(group.description).to eq(@group_desc)
          expect(group.unsubscribes).to eq(0)
        end

        it '#patch_group' do
          @group1.name = @group_name_edit1
          @group1.description = @group_desc_edit
          group_edit1 = @client.patch_group(
            group_id: @group1.id, group: @group1
          )
          expect(group_edit1.id).to be_a(Fixnum)
          expect(group_edit1.name).to eq(@group_name_edit1)
          expect(group_edit1.description).to eq(@group_desc_edit)
          expect(group_edit1.unsubscribes).to eq(nil)
        end

        it '#delete_group' do
          @client.delete_group(group_id: @group1.id)
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
            '"last_email_sent_at": null,'\
            '"is_default": true,'\
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
              '"last_email_sent_at": null,'\
              '"is_default": true,'\
              '"unsubscribes": 400'\
            '},'\
            '{'\
              '"id": 101,'\
              '"name": "Alerts",'\
              '"description": "Emails triggered by user-defined rules.",'\
              '"last_email_sent_at": null,'\
              '"is_default": false,'\
              '"unsubscribes": 1'\
            '}'\
          ']'
        )
      end

      it '#post_group' do
        allow(client).to receive(:execute).and_return(group)
        actual = client.post_group(name: '', description: '')
        expect(actual).to be_a(Groups::Group)
      end

      it '#patch_group' do
        allow(client).to receive(:execute).and_return(group)
        actual = client.patch_group(group_id: 0, group: nil)
        expect(actual).to be_a(Groups::Group)
      end

      it '#get_groups' do
        allow(client).to receive(:execute).and_return(groups)
        actual = client.get_groups
        expect(actual).to be_a(Array)
        actual.each do |group|
          expect(group).to be_a(Groups::Group)
        end
      end

      it '#get_group' do
        allow(client).to receive(:execute).and_return(group)
        actual = client.get_group(group_id: 0)
        expect(actual).to be_a(Groups::Group)
      end

      it '#delete_group' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_group(group_id: 0)
        expect(actual).to eq('')
      end

      it 'creates group instance' do
        actual = Groups.create_group(group)
        expect(actual).to be_a(Groups::Group)
        expect(actual.id).to eq(100)
        expect(actual.name).to eq('Newsletters')
        expect(actual.description).to eq('Our monthly newsletter.')
        expect(actual.last_email_sent_at).to eq(nil)
        expect(actual.is_default).to eq(true)
        expect(actual.unsubscribes).to eq(400)
      end

      it 'creates groups instance' do
        actual = Groups.create_groups(groups)
        expect(actual).to be_a(Array)
        actual.each do |group|
          expect(group).to be_a(Groups::Group)
        end
      end
    end
  end
end
