# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe CampaignFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
        @campaign_factory = CampaignFactory.new
      end

      it 'specify all params' do
        campaign = @campaign_factory.create(
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
        @expect = {}
        @expect[:title] = 'March Newsletter'
        @expect[:subject] = 'New Products for Spring!'
        @expect[:sender_id] = 124451
        @expect[:list_ids] = [110, 124]
        @expect[:segment_ids] = [110]
        @expect[:categories] = ['spring line']
        @expect[:suppression_group_id] = 42
        @expect[:custom_unsubscribe_url] = 'https://sendgrid.com'
        @expect[:ip_pool] = 'marketing'
        @expect[:html_content] = '<html><head><title></title></head><body>'\
          '<p>Check out our spring line!</p></body></html>'
        @expect[:plain_content] = 'Check out our spring line!'
        expect(campaign).to eq(@expect)
      end
    end
  end
end
