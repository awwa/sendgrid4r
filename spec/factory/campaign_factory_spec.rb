# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe CampaignFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it 'specify mandatory params' do
        campaign = CampaignFactory.new.create
        expect(campaign).to eq({})
      end

      it 'specify all params' do
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
    end
  end
end
