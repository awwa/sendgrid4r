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
          settings = SendGrid4r::Factory::MailFactory.create_mail_settings
          expect(settings.to_h).to eq({})
        end

        it '#to_h with full parameters enable' do
          settings = SendGrid4r::Factory::MailFactory.create_mail_settings
          settings.enable_bcc('bcc@example.com')
          settings.enable_bypass_list_management
          settings.enable_footer('text', 'html')
          settings.enable_sandbox_mode
          settings.enable_spam_check(5, 'http://post.url')
          expect(settings.to_h).to eq(
            bcc: { enable: true, email: 'bcc@example.com' },
            bypass_list_management: { enable: true },
            footer: { enable: true, text: 'text', html: 'html' },
            sandbox_mode: { enable: true },
            spam_check: {
              enable: true, threshold: 5, post_to_url: 'http://post.url'
            }
          )
        end

        it '#to_h with full parameters disable' do
          settings = SendGrid4r::Factory::MailFactory.create_mail_settings
          settings.disable_bcc
          settings.disable_bypass_list_management
          settings.disable_footer
          settings.disable_sandbox_mode
          settings.disable_spam_check
          expect(settings.to_h).to eq(
            bcc: { enable: false },
            bypass_list_management: { enable: false },
            footer: { enable: false },
            sandbox_mode: { enable: false },
            spam_check: { enable: false }
          )
        end
      end
    end
  end
end
