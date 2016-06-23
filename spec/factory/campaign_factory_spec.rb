# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe CampaignFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it 'create with mandatory parameters' do
        campaign = CampaignFactory.new.create
        expect(campaign).to eq({})
      end

      it 'create with full parameters' do
        campaign = CampaignFactory.new.create(
          title: 'March Newsletter',
          subject: 'New Products for Spring!',
          sender_id: 124451,
          list_ids: [110, 124],
          segment_ids: [110],
          categories: ['spring line'],
          suppression_group_id: 42,
          custom_unsubscribe_url: 'https://sendgrid.com',
          ip_pool: 'marketing',
          html_content: '<html><head><title></title></head><body>'\
            '<p>Check out our spring line!</p></body></html>',
          plain_content: 'Check out our spring line!'
        )
        expect(campaign).to eq(
          title: 'March Newsletter',
          subject:  'New Products for Spring!',
          sender_id:  124451,
          list_ids:  [110, 124],
          segment_ids:  [110],
          categories:  ['spring line'],
          suppression_group_id:  42,
          custom_unsubscribe_url:  'https://sendgrid.com',
          ip_pool:  'marketing',
          html_content:  '<html><head><title></title></head><body>'\
            '<p>Check out our spring line!</p></body></html>',
          plain_content:  'Check out our spring line!'
        )
      end

      it 'create address with full parameters' do
        address = CampaignFactory.new.create_address(
          email: 'from@example.com', name: 'Example INC'
        )
        expect(address[:email]).to eq('from@example.com')
        expect(address[:name]).to eq('Example INC')
      end

      it 'create sender with full parameters' do
        from = CampaignFactory.new.create_address(
          email: 'from@example.com', name: 'Example INC'
        )
        reply_to = CampaignFactory.new.create_address(
          email: 'replyto@example.com', name: 'Example INC'
        )
        sender = CampaignFactory.new.create_sender(
          nickname: 'My Sender ID', from: from, reply_to: reply_to,
          address: '123 Elm St.', address_2: 'Apt. 456',
          city: 'Denver', state: 'Colorado', zip: '80202',
          country: 'United States'
        )
        expect(sender.nickname).to eq('My Sender ID')
        expect(sender.from[:email]).to eq('from@example.com')
        expect(sender.from[:name]).to eq('Example INC')
        expect(sender.reply_to[:email]).to eq('replyto@example.com')
        expect(sender.reply_to[:name]).to eq('Example INC')
        expect(sender.address).to eq('123 Elm St.')
        expect(sender.address_2).to eq('Apt. 456')
        expect(sender.city).to eq('Denver')
        expect(sender.state).to eq('Colorado')
        expect(sender.zip).to eq('80202')
        expect(sender.country).to eq('United States')
      end
    end
  end
end
