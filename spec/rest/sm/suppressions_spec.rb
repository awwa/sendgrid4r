# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Sm
  describe Suppressions do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @email1 = 'test1@test.com'
        @email2 = 'test2@test.com'
        @email3 = 'test3@test.com'
        @group_name = 'suppressions_test'
        @group_desc = 'group_desc'

        # celan up test env
        grps = @client.get_groups
        grps.each do |grp|
          next if grp.name != @group_name
          emails = @client.get_suppressed_emails(group_id: grp.id)
          emails.each do |email|
            @client.delete_suppressed_email(
              group_id: grp.id, email_address: email
            )
          end
          @client.delete_group(group_id: grp.id)
        end
        # post a group
        @group = @client.post_group(name: @group_name, description: @group_desc)
        # post suppressed email
        @client.post_suppressed_emails(
          group_id: @group.id, recipient_emails: [@email1]
        )
      end

      context 'wthout block call' do
        it '#post_suppressed_emails' do
          emails = @client.post_suppressed_emails(
            group_id: @group.id, recipient_emails: [@email2, @email3]
          )
          expect(emails.recipient_emails.length).to eq(2)
          expect(emails.recipient_emails[0]).to eq(@email2)
          expect(emails.recipient_emails[1]).to eq(@email3)
        end

        it '#search_suppressed_emails' do
          emails = @client.search_suppressed_emails(
            group_id: @group.id, recipient_emails: [@email1]
          )
          expect(emails.length).to eq(1)
          expect(emails[0]).to eq(@email1)
        end

        it '#get_suppressed_emails' do
          emails = @client.get_suppressed_emails(group_id: @group.id)
          expect(emails.length).to eq(1)
          expect(emails[0]).to eq(@email1)
        end

        it '#get_suppressions with email' do
          groups = @client.get_suppressions(email_address: @email1)
          expect(groups.suppressions).to be_a(Array)
          groups.suppressions.each do |group|
            next unless group.name == @group_name
            expect(group.name).to eq(@group_name)
            expect(group.description).to eq(@group_desc)
            expect(group.suppressed).to eq(true)
            expect(group.is_default).to eq(false)
          end
        end

        it '#get_suppressions without email' do
          suppressions = @client.get_suppressions
          expect(suppressions).to be_a(Array)
          suppressions.each do |suppression|
            expect(suppression).to be_a(Suppressions::Suppression)
          end
        end

        it '#delete_suppressed_email' do
          @client.delete_suppressed_email(
            group_id: @group.id, email_address: @email1
          )
          @client.delete_suppressed_email(
            group_id: @group.id, email_address: @email2
          )
          @client.delete_suppressed_email(
            group_id: @group.id, email_address: @email3
          )
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:recipient_emails) do
        '{'\
          '"recipient_emails": ['\
            '"test1@example.com",'\
            '"test2@example.com"'\
          ']'\
        '}'
      end

      let(:recipient_email) do
        '{'\
          '"recipient_email": "test1@example.com"'\
        '}'
      end

      let(:emails) do
        '["test1@example.com","test2@example.com"]'
      end

      let(:group) do
        '{'\
          '"description": "Optional description.",'\
          '"id": 1,'\
          '"is_default": true,'\
          '"name": "Weekly News",'\
          '"suppressed": true'\
        '}'
      end

      let(:groups) do
        '{'\
          '"suppressions": ['\
            '{'\
              '"description": "Optional description.",'\
              '"id": 1,'\
              '"is_default": true,'\
              '"name": "Weekly News",'\
              '"suppressed": true'\
            '},'\
            '{'\
              '"description": "Some daily news.",'\
              '"id": 2,'\
              '"is_default": true,'\
              '"name": "Daily News",'\
              '"suppressed": true'\
            '},'\
            '{'\
              '"description": "An old group.",'\
              '"id": 2,'\
              '"is_default": false,'\
              '"name": "Old News",'\
              '"suppressed": false'\
            '}'\
          ']'\
        '}'
      end

      let(:suppression) do
        '{'\
          '"email":"test@example.com",'\
          '"group_id": 1,'\
          '"group_name": "Weekly News",'\
          '"created_at": 1410986704'\
        '}'
      end

      it '#post_suppressed_emails' do
        allow(client).to receive(:execute).and_return(recipient_emails)
        actual = client.post_suppressed_emails(
          group_id: 0, recipient_emails: ['', '']
        )
        expect(actual).to be_a(RecipientEmails)
      end

      it '#search_suppressed_emails' do
        allow(client).to receive(:execute).and_return(emails)
        actual = client.search_suppressed_emails(
          group_id: 0, recipient_emails: ['', '']
        )
        expect(actual).to be_a(Array)
      end

      it '#get_suppressed_emails' do
        allow(client).to receive(:execute).and_return(emails)
        actual = client.get_suppressed_emails(group_id: 0)
        expect(actual).to be_a(Array)
      end

      it '#get_suppressions' do
        allow(client).to receive(:execute).and_return(groups)
        actual = client.get_suppressions(email_address: '')
        expect(actual.suppressions).to be_a(Array)
        actual.suppressions.each do |group|
          expect(group).to be_a(Suppressions::Group)
        end
      end

      it '#delete_suppressed_email' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_suppressed_email(group_id: 0, email_address: '')
        expect(actual).to eq('')
      end

      it 'creates group instance' do
        actual = Suppressions.create_group(JSON.parse(group))
        expect(actual).to be_a(Suppressions::Group)
        expect(actual.id).to eq(1)
        expect(actual.name).to eq('Weekly News')
        expect(actual.description).to eq('Optional description.')
        expect(actual.suppressed).to eq(true)
        expect(actual.is_default).to eq(true)
      end

      it 'creates groups instance' do
        actual = Suppressions.create_groups(JSON.parse(groups))
        expect(actual).to be_a(Suppressions::Groups)
        expect(actual.suppressions).to be_a(Array)
        actual.suppressions.each do |group|
          expect(group).to be_a(Suppressions::Group)
        end
      end

      it 'create suppression instance' do
        actual = Suppressions.create_suppression(JSON.parse(suppression))
        expect(actual).to be_a(Suppressions::Suppression)
        expect(actual.email).to eq('test@example.com')
        expect(actual.group_id).to eq(1)
        expect(actual.group_name).to eq('Weekly News')
        expect(actual.created_at).to eq(Time.at(1410986704))
      end
    end
  end
end
