# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Campaigns::Campaigns do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['KN_API_KEY'])
      @title1 = 'Test Title1'
      @title2 = 'Test Title2'
      @title1_edit = 'Edit Title1'
      @subject1 = 'Subject1'
      @subject2 = 'Subject2'

      @email1 = 'test@example.com'
      @last_name1 = 'Last Name1'
      @list_name1 = 'List Name1'
      @group_name1 = 'Group Name1'
      @pool_name1 = 'pool_test1'

      # celan up test env
      # delete campaigns
      campaigns = @client.get_campaigns
      campaigns.result.each do |campaign|
        @client.delete_campaign(
          campaign_id: campaign.id
        ) if campaign.title == @title1
        @client.delete_campaign(
          campaign_id: campaign.id
        ) if campaign.title == @title2
        @client.delete_campaign(
          campaign_id: campaign.id
        ) if campaign.title == @title1_edit
      end
      # delete recipients
      recipients = @client.get_recipients
      recipients.recipients.each do |recipient|
        next if recipient.email != @email1
        @client.delete_recipient(recipient_id: recipient.id)
      end
      # delete lists
      lists = @client.get_lists
      lists.lists.each do |list|
        next if list.name != @list_name1
        @client.delete_list(list_id: list.id)
      end
      # delete suppression groups
      grps = @client.get_groups
      grps.each do |grp|
        next if grp.name != @group_name1
        @client.delete_group(group_id: grp.id)
      end
      # delete ip pools
      pools = @client.get_pools
      pools.each do |pool|
        @client.delete_pool(name: pool.name) if pool.name == @pool_name1
      end
      # post a recipient
      recipient1 = {}
      recipient1['email'] = @email1
      recipient1['last_name'] = @last_name1
      @result = @client.post_recipients(params: [recipient1])
      # post a list
      @list1 = @client.post_list(name: @list_name1)
      # add a recipient to the list
      @client.post_recipient_to_list(
        list_id: @list1.id, recipient_id: @result.persisted_recipients[0]
      )
      # add a group
      @group1 = @client.post_group(name: @group_name1, description: 'test')
      # add an ip pool
      @pool1 = @client.post_pool(name: @pool_name1)
      # add a campaign
      @campaign_factory = SendGrid4r::Factory::CampaignFactory.new
      @params = @campaign_factory.create(
        title: @title1, subject: @subject1, sender_id: 516,
        list_ids: [@list1.id], categories: ['cat1'],
        suppression_group_id: @group1.id,
        html_content: 'html <a href="[unsubscribe]">unsub</a>',
        plain_content: 'plain [unsubscribe]')
      @campaign1 = @client.post_campaign(params: @params)
    end

    context 'without block call' do
      it '#post_campaign' do
        params = @campaign_factory.create(
          title: @title2, subject: @subject2, sender_id: 516,
          list_ids: [@list1.id], categories: ['cat1'],
          suppression_group_id: @group1.id, html_content: 'html',
          plain_content: 'plain')
        campaign2 = @client.post_campaign(params: params)
        expect(campaign2.title).to eq(@title2)
        expect(campaign2.subject).to eq(@subject2)
        expect(campaign2.sender_id).to eq(516)
        expect(campaign2.list_ids).to eq([@list1.id])
        expect(campaign2.categories).to eq(['cat1'])
        expect(campaign2.suppression_group_id).to eq(@group1.id)
        expect(campaign2.html_content).to eq('html')
        expect(campaign2.plain_content).to eq('plain')
      end

      it '#post_campaign with custom_unsubscribe_url' do
        params = @campaign_factory.create(
          title: @title2, subject: @subject2, sender_id: 516,
          list_ids: [@list1.id], categories: ['cat1'],
          custom_unsubscribe_url: 'https://sendgrid.com',
          ip_pool: @pool_name1, html_content: 'html', plain_content: 'plain')
        campaign2 = @client.post_campaign(params: params)
        expect(campaign2.title).to eq(@title2)
        expect(campaign2.subject).to eq(@subject2)
        expect(campaign2.sender_id).to eq(516)
        expect(campaign2.list_ids).to eq([@list1.id])
        expect(campaign2.categories).to eq(['cat1'])
        expect(campaign2.html_content).to eq('html')
        expect(campaign2.plain_content).to eq('plain')
      end

      it '#get_campaigns' do
        campaigns = @client.get_campaigns
        expect(campaigns.length).to be >= 1
        campaigns.result.each do |campaign|
          next if campaign.title != @title1
          expect(campaign.title).to eq(@title1)
        end
      end

      it '#get_campaign' do
        campaign = @client.get_campaign(campaign_id: @campaign1.id)
        expect(campaign).to eq(@campaign1)
      end

      it '#delete_campaign' do
        @client.delete_campaign(campaign_id: @campaign1.id)
        expect do
          @client.delete_campaign(campaign_id: @campaign1.id)
        end.to raise_error(RestClient::ResourceNotFound)
      end

      it '#patch_campaign' do
        @campaign1.title = @title1_edit
        actual = @client.patch_campaign(
          campaign_id: @campaign1.id, params: @campaign1
        )
        expect(actual.title).to eq(@title1_edit)
      end

      it '#send_campaign' do
        actual = @client.send_campaign(campaign_id: @campaign1.id)
        expect(actual.id).to eq(@campaign1.id)
        expect(actual.status).to eq('Scheduled')
      end

      it '#schedule_campaign' do
        send_at = Time.at(Time.now.to_i, 0)
        actual = @client.schedule_campaign(
          campaign_id: @campaign1.id,
          send_at: send_at
        )
        expect(actual.id).to eq(@campaign1.id)
        expect(actual.status).to eq('Scheduled')
        expect(actual.send_at).to eq(send_at)
      end

      it '#reschedule_campaign' do
        send_at = Time.at(Time.now.to_i, 0)
        @client.schedule_campaign(
          campaign_id: @campaign1.id,
          send_at: send_at
        )
        send_at = Time.at(Time.now.to_i, 0)
        actual = @client.reschedule_campaign(
          campaign_id: @campaign1.id,
          send_at: send_at
        )
        expect(actual.id).to eq(@campaign1.id)
        expect(actual.status).to eq('Scheduled')
        expect(actual.send_at).to eq(send_at)
      end

      it '#get_schedule_time_campaign' do
        send_at = Time.at(Time.now.to_i, 0)
        @client.schedule_campaign(
          campaign_id: @campaign1.id,
          send_at: send_at
        )
        actual = @client.get_schedule_time_campaign(
          campaign_id: @campaign1.id
        )
        expect(actual.send_at).to eq(send_at)
      end

      it '#unschedule_campaign' do
        send_at = Time.at(Time.now.to_i, 0)
        @client.schedule_campaign(
          campaign_id: @campaign1.id, send_at: send_at
        )
        @client.unschedule_campaign(campaign_id: @campaign1.id)
      end

      it '#test_campaign' do
        @client.test_campaign(campaign_id: @campaign1.id, to: ENV['MAIL'])
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:campaign) do
      JSON.parse(
        '{'\
          '"id": 986724,'\
          '"title": "March Newsletter",'\
          '"subject": "New Products for Spring!",'\
          '"sender_id": 124451,'\
          '"list_ids": ['\
            '110,'\
            '124'\
          '],'\
          '"segment_ids": ['\
            '110'\
          '],'\
          '"categories": ['\
            '"spring line"'\
          '],'\
          '"suppression_group_id": 42,'\
          '"custom_unsubscribe_url": "",'\
          '"ip_pool": "marketing",'\
          '"html_content": "<html><head><title></title></head><body>'\
            '<p>Check out our spring line!</p></body></html>",'\
          '"plain_content": "Check out our spring line!",'\
          '"status": "Draft"'\
        '}'
      )
    end

    let(:campaigns) do
      JSON.parse(
        '{'\
          '"result": ['\
            '{'\
              '"id": 986724,'\
              '"title": "March Newsletter",'\
              '"subject": "New Products for Spring!",'\
              '"sender_id": 124451,'\
              '"list_ids": ['\
                '110,'\
                '124'\
              '],'\
              '"segment_ids": ['\
                '110'\
              '],'\
              '"categories": ['\
                '"spring line"'\
              '],'\
              '"suppression_group_id": 42,'\
              '"custom_unsubscribe_url": "",'\
              '"ip_pool": "marketing",'\
              '"html_content": "<html><head><title></title></head><body>'\
                '<p>Check out our spring line!</p></body></html>",'\
              '"plain_content": "Check out our spring line!",'\
              '"status": "Draft"'\
            '},'\
            '{'\
              '"id": 986723,'\
              '"title": "February Newsletter",'\
              '"subject": "Final Winter Product Sale!",'\
              '"sender_id": 124451,'\
              '"list_ids": ['\
                '110,'\
                '124'\
              '],'\
              '"segment_ids": ['\
                '110'\
              '],'\
              '"categories": ['\
                '"winter line"'\
              '],'\
              '"suppression_group_id": 42,'\
              '"custom_unsubscribe_url": "",'\
              '"ip_pool": "marketing",'\
              '"html_content": "<html><head><title></title></head><body>'\
                '<p>Last call for winter clothes!</p></body></html>",'\
              '"plain_content": "Last call for winter clothes!",'\
              '"status": "Sent"'\
            '}'\
          ']'\
        '}'
      )
    end

    let(:sent) do
      JSON.parse(
        '{'\
          '"id": 986724,'\
          '"status": "Scheduled"'\
        '}'
      )
    end

    let(:schedule) do
      JSON.parse(
        '{'\
          '"id": 986724,'\
          '"send_at": 1489771528,'\
          '"status": "Scheduled"'\
        '}'
      )
    end

    it '#post_campaign' do
      allow(client).to receive(:execute).and_return(campaign)
      actual = client.post_campaign(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#get_campaigns' do
      allow(client).to receive(:execute).and_return(campaigns)
      actual = client.get_campaigns
      expect(actual).to be_a(
        SendGrid4r::REST::Campaigns::Campaigns::Campaigns
      )
    end

    it '#get_campaign' do
      allow(client).to receive(:execute).and_return(campaign)
      actual = client.get_campaign(campaign_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#delete_campaign' do
      allow(client).to receive(:execute).and_return('')
      client.delete_campaign(campaign_id: 0)
    end

    it '#patch_campaign' do
      allow(client).to receive(:execute).and_return(campaign)
      actual = client.patch_campaign(campaign_id: 0, params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#send_campaign' do
      allow(client).to receive(:execute).and_return(sent)
      actual = client.send_campaign(campaign_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#schedule_campaign' do
      allow(client).to receive(:execute).and_return(schedule)
      actual = client.schedule_campaign(campaign_id: 0, send_at: nil)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#reschedule_campaign' do
      allow(client).to receive(:execute).and_return(schedule)
      actual = client.reschedule_campaign(campaign_id: 0, send_at: nil)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#get_schedule_time_campaign' do
      allow(client).to receive(:execute).and_return(schedule)
      actual = client.get_schedule_time_campaign(campaign_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
    end

    it '#unschedule_campaign' do
      allow(client).to receive(:execute).and_return('')
      actual = client.unschedule_campaign(campaign_id: 0)
      expect(actual).to eq('')
    end

    it '#test_campaign' do
      allow(client).to receive(:execute).and_return('')
      actual = client.test_campaign(campaign_id: 0, to: '')
      expect(actual).to eq('')
    end

    it 'creates campaign instance' do
      actual = SendGrid4r::REST::Campaigns::Campaigns.create_campaign(campaign)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
      expect(actual.id).to eq(986724)
      expect(actual.title).to eq('March Newsletter')
      expect(actual.subject).to eq('New Products for Spring!')
      expect(actual.sender_id).to eq(124451)
      expect(actual.list_ids).to eq([110, 124])
      expect(actual.segment_ids).to eq([110])
      expect(actual.categories).to eq(['spring line'])
      expect(actual.suppression_group_id).to eq(42)
      expect(actual.custom_unsubscribe_url).to eq('')
      expect(actual.ip_pool).to eq('marketing')
      expect(actual.html_content).to eq(
        '<html><head><title></title></head><body>'\
        '<p>Check out our spring line!</p></body></html>')
      expect(actual.plain_content).to eq('Check out our spring line!')
      expect(actual.status).to eq('Draft')
    end

    it 'creates campaigns instance' do
      actual = SendGrid4r::REST::Campaigns::Campaigns.create_campaigns(
        campaigns
      )
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaigns)
      actual.result.each do |campaign|
        expect(campaign).to be_a(
          SendGrid4r::REST::Campaigns::Campaigns::Campaign
        )
      end
    end

    it 'creates sent instance' do
      actual = SendGrid4r::REST::Campaigns::Campaigns.create_campaign(sent)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
      expect(actual.id).to eq(986724)
      expect(actual.status).to eq('Scheduled')
    end

    it 'creates schedule instance' do
      actual = SendGrid4r::REST::Campaigns::Campaigns.create_campaign(schedule)
      expect(actual).to be_a(SendGrid4r::REST::Campaigns::Campaigns::Campaign)
      expect(actual.id).to eq(986724)
      expect(actual.send_at).to eq(Time.at(1489771528))
      expect(actual.status).to eq('Scheduled')
    end
  end
end
