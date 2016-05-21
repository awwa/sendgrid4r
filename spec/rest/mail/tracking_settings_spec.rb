# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST
  describe Mail do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end
      context 'without block call' do
        it '#to_h with mandatory parameters' do
          settings =
            SendGrid4r::Factory::MailFactory.create_tracking_settings
          expect(settings.to_h).to eq({})
        end

        it '#to_h with full parameters enable' do
          settings =
            SendGrid4r::Factory::MailFactory.create_tracking_settings
          settings.enable_click_tracking(true)
          settings.enable_open_tracking('<tag>')
          settings.enable_subscription_tracking('text', 'html', '<tag>')
          settings.enable_ganalytics(
            'source', 'medium', 'term', 'content', 'campaign'
          )
          expect(settings.to_h).to eq(
            click_tracking: { enable: true, enable_text: true },
            open_tracking: {
              enable: true,
              substitution_tag: '<tag>'
            },
            subscription_tracking: {
              enable: true, text: 'text', html: 'html',
              substitution_tag: '<tag>'
            },
            ganalytics: {
              enable: true,
              utm_source: 'source',
              utm_medium: 'medium',
              utm_term: 'term',
              utm_content: 'content',
              utm_campaign: 'campaign'
            }
          )
        end

        it '#to_h with full parameters disable' do
          settings =
            SendGrid4r::Factory::MailFactory.create_tracking_settings
          settings.disable_click_tracking
          settings.disable_open_tracking
          settings.disable_subscription_tracking
          settings.disable_ganalytics
          expect(settings.to_h).to eq(
            click_tracking: { enable: false },
            open_tracking: { enable: false },
            subscription_tracking: { enable: false },
            ganalytics: { enable: false }
          )
        end
      end
    end
  end
end
