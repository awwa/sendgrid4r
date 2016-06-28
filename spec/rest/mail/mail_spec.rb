# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST
  describe Mail do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#send with mandatory params' do
          # Create Personalization
          to = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['MAIL']
          )
          per = SendGrid4r::Factory::MailFactory.create_personalization(
            to: [to]
          )
          # Create Params
          from = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['FROM']
          )
          plain = SendGrid4r::Factory::MailFactory.create_content(
            type: 'text/plain',
            value: 'Hello! TEXT　天翔十字鳳'
          )
          params = SendGrid4r::Factory::MailFactory.create_params(
            personalizations: [per], from: from, content: [plain],
            subject: 'Hello v3 Mail　天翔十字鳳'
          )
          begin
            @client.send(params: params)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise
          end
        end

        it '#send with full params' do
          # Create Personalization
          to = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['MAIL'], name: 'To name'
          )
          cc = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['CC'], name: 'Cc name'
          )
          bcc = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['BCC'], name: 'Bcc name'
          )
          per = SendGrid4r::Factory::MailFactory.create_personalization(
            to: [to]
          )
          per.bcc = [bcc]
          per.cc = [cc]
          per.headers = { 'X-CUSTOM' => 'X-VALUE' }
          per.substitutions = {
            'subkey' => 'subvalueサブ値', 'sectionkey' => 'sectionkey'
          }
          per.custom_args = { 'CUSTOM' => 'value' }
          per.send_at = Time.utc(2016)
          # Create Params
          from = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['FROM'], name: 'From Name'
          )
          plain = SendGrid4r::Factory::MailFactory.create_content(
            type: 'text/plain',
            value: 'Hello! TEXT 天翔十字鳳 subkey'\
              'sectionkey\nhttps://www.google.com'
          )
          html = SendGrid4r::Factory::MailFactory.create_content(
            type: 'text/html',
            value: "<h1>Hello! HTML subkey sectionkey</h1><br />"\
              '<a href="https://www.google.com">Google</a>'
          )
          params = SendGrid4r::Factory::MailFactory.create_params(
            personalizations: [per], from: from, content: [plain, html],
            subject: 'Hello v3 Mail　天翔十字鳳 '
          )
          reply_to = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['MAIL']
          )
          params.reply_to = reply_to
          attachment0 = SendGrid4r::Factory::MailFactory.create_attachment(
            content: 'XXX', filename: 'text.txt'
          )
          binary = File.binread(File.dirname(__FILE__) + '/../../photo.jpg')
          attachment1 = SendGrid4r::Factory::MailFactory.create_attachment(
            content: binary, filename: 'photo.jpg'
          )
          params.attachments = [attachment0, attachment1]
          params.template_id = '8481d009-d1a6-4e1b-adae-22d2426da9fe'
          params.sections = { 'sectionkey' => 'sectionvalueセクション値' }
          params.headers = { 'X-GLOBAL' => 'GLOBAL_VALUE' }
          params.categories = %w(CAT1 CAT2)
          params.custom_args = { 'CUSTOM1' => 'CUSTOM_VALUE1' }
          params.send_at = Time.local(2016)
          params.asm = 3581
          # Create MailSettings
          mail_settings =
            SendGrid4r::Factory::MailFactory.create_mail_settings
          mail_settings.enable_bcc(ENV['MAIL'])
          mail_settings.disable_bcc
          mail_settings.enable_bypass_list_management
          mail_settings.disable_bypass_list_management
          mail_settings.enable_footer('text footer', '<p>html footer</p>')
          mail_settings.disable_footer
          mail_settings.enable_sandbox_mode
          mail_settings.disable_sandbox_mode
          mail_settings.enable_spam_check(10, 'http://www.kke.co.jp')
          mail_settings.disable_spam_check
          params.mail_settings = mail_settings
          # Create TrackingSettings
          tracking =
            SendGrid4r::Factory::MailFactory.create_tracking_settings
          tracking.enable_click_tracking(true)
          tracking.disable_click_tracking
          tracking.enable_open_tracking('open_tag')
          tracking.disable_open_tracking
          tracking.enable_subscription_tracking('', '', 'tag')
          tracking.disable_subscription_tracking
          tracking.enable_ganalytics('', '', '', '', '')
          tracking.disable_ganalytics
          params.tracking_settings = tracking
          begin
            @client.send(params: params)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise
          end
        end
      end
    end
  end
end
