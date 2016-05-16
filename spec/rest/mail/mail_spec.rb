# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'
require 'json'

module SendGrid4r::REST
  describe Mail do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#send' do
          begin
            to = SendGrid4r::Factory::MailFactory.create_email(
              email: ENV['MAIL'], name: 'To name'
            )
            cc = SendGrid4r::Factory::MailFactory.create_email(
              email: ENV['CC']
            )
            bcc = SendGrid4r::Factory::MailFactory.create_email(
              email: ENV['BCC'], name: 'Bcc name'
            )
            per = SendGrid4r::Factory::MailFactory.create_personalization(
              tos: [to], subject: 'Hello v3 Mail'
            )
            per.set_bccs([bcc])
            per.set_ccs([cc])
            per.set_headers('X-CUSTOM' => 'X-VALUE')
            per.set_substitutions(
              'subkey' => '置換値', 'sectionkey' => 'sectionkey'
            )
            per.set_custom_args('CUSTOM' => 'value')
            per.set_send_at(Time.local(2016))
            from = SendGrid4r::Factory::MailFactory.create_email(
              email: ENV['FROM'], name: 'From Name'
            )
            plain = SendGrid4r::Factory::MailFactory.create_content(
              type: 'text/plain',
              value: 'こんにちは!TEXT subkey sectionkey\nhttps://www.google.com'
            )
            html = SendGrid4r::Factory::MailFactory.create_content(
              type: 'text/html',
              value: '<h1>こんにちは!HTML subkey sectionkey</h1><br />'\
                '<a href="https://www.google.com">ぐーぐる</a>'
            )
            params = SendGrid4r::Factory::MailFactory.create_params(
              personalizations: [per], from: from, contents: [plain, html]
            )
            reply_to = SendGrid4r::Factory::MailFactory.create_email(
              email: ENV['MAIL']
            )
            params.set_reply_to(reply_to)
            attachment = SendGrid4r::Factory::MailFactory.create_attachment(
              content: 'XXX', filename: 'text.txt'
            )
            params.set_attachments([attachment])
            params.set_template_id('8481d009-d1a6-4e1b-adae-22d2426da9fe')
            params.set_sections('sectionkey' => 'セクション置換')
            params.set_headers('X-GLOBAL' => 'GLOBAL_VALUE')
            params.set_categories(%w('CAT1', 'CAT2'))
            params.set_custom_args('CUSTOM1' => 'CUSTOM_VALUE1')
            params.set_send_at(Time.local(2016))
            params.set_asm(3581)

            mail_settings =
              SendGrid4r::Factory::MailFactory.create_mail_settings
            mail_settings.set_bcc(true, ENV['MAIL'])
            mail_settings.set_bcc(false)
            mail_settings.set_bypass_list_management(true)
            mail_settings.set_bypass_list_management(false)
            mail_settings.set_footer(true, 'text footer', '<p>html footer</p>')
            mail_settings.set_footer(false)
            mail_settings.set_sandbox_mode(true)
            mail_settings.set_sandbox_mode(false)
            mail_settings.set_spam_check(true, 10, 'http://www.kke.co.jp')
            mail_settings.set_spam_check(false)
            params.set_mail_settings(mail_settings)

            tracking =
              SendGrid4r::Factory::MailFactory.create_tracking_settings
            tracking.set_click_tracking(true, true)
            tracking.set_click_tracking(false)
            tracking.set_open_tracking(true, 'open_tag')
            tracking.set_open_tracking(false)
            tracking.set_subscription_tracking(true, '', '', 'tag')
            tracking.set_subscription_tracking(false)
            tracking.set_ganalytics(true, '', '', '', '', '')
            tracking.set_ganalytics(false)
            params.set_tracking_settings(tracking)

            puts "= params: #{params.to_h}"

            @client.send(params: params)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end
      end
    end
  end
end
