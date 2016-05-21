# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST
  describe Mail do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      let(:to) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: 'to@example.com'
        )
      end

      let(:from) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: 'from@example.com'
        )
      end

      let(:per) do
        SendGrid4r::Factory::MailFactory.create_personalization(
          to: [to], subject: 'Hello v3 Mail'
        )
      end

      let(:plain) do
        SendGrid4r::Factory::MailFactory.create_content(
          type: 'text/plain',
          value: 'こんにちは!TEXT subkey '\
            'sectionkey\nhttps://www.google.com'
        )
      end

      let(:html) do
        SendGrid4r::Factory::MailFactory.create_content(
          type: 'text/html',
          value: '<h1>こんにちは!HTML subkey sectionkey</h1><br />'\
            '<a href="https://www.google.com">ぐーぐる</a>'
        )
      end

      let(:reply_to) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: 'reply_to@example.com'
        )
      end

      let(:attachment) do
        SendGrid4r::Factory::MailFactory.create_attachment(
          content: 'Hello', filename: 'text.txt'
        )
      end

      let(:mail_settings) do
        SendGrid4r::Factory::MailFactory.create_mail_settings
      end

      let(:tracking_settings) do
        SendGrid4r::Factory::MailFactory.create_tracking_settings
      end

      context 'without block call' do
        it '#to_h with mandatory parameters' do
          params = SendGrid4r::Factory::MailFactory.create_params(
            personalizations: [per], from: from, content: [plain, html]
          )
          expect(params.to_h).to eq(
            personalizations: [
              {
                to: [{ email: 'to@example.com' }],
                subject: 'Hello v3 Mail'
              }
            ],
            from: { email: 'from@example.com' },
            content: [
              {
                type: 'text/plain',
                value: 'こんにちは!TEXT subkey '\
                  'sectionkey\nhttps://www.google.com'
              },
              {
                type: 'text/html',
                value: '<h1>こんにちは!HTML subkey sectionkey</h1><br />'\
                  '<a href="https://www.google.com">ぐーぐる</a>'
              }
            ]
          )
        end

        it '#to_h with full parameters' do
          params = SendGrid4r::Factory::MailFactory.create_params(
            personalizations: [per], from: from, content: [plain, html]
          )
          params.reply_to = reply_to
          params.attachments = [attachment]
          params.template_id = 'XXX-YYY-ZZZ'
          params.sections = { 'sectionkey' => 'セクション置換' }
          params.headers = { 'X-GLOBAL' => 'GLOBAL_VALUE' }
          params.categories = %w(CAT1 CAT2)
          params.custom_args = { 'CUSTOM1' => 'CUSTOM_VALUE1' }
          params.send_at = Time.utc(2016)
          params.batch_id = '1234567890'
          params.asm = 3581, [12, 34]
          params.ip_pool_name = 'pool_name'
          params.mail_settings = mail_settings
          params.tracking_settings = tracking_settings

          expect(params.to_h).to eq(
            personalizations: [
              {
                to: [{ email: 'to@example.com' }],
                subject: 'Hello v3 Mail'
              }
            ],
            from: { email: 'from@example.com' },
            content: [
              {
                type: 'text/plain',
                value: 'こんにちは!TEXT subkey '\
                  'sectionkey\nhttps://www.google.com'
              },
              {
                type: 'text/html',
                value: '<h1>こんにちは!HTML subkey sectionkey</h1><br />'\
                  '<a href="https://www.google.com">ぐーぐる</a>'
              }
            ],
            reply_to: { email: 'reply_to@example.com' },
            attachments: [
              {
                content: 'SGVsbG8=',
                filename: 'text.txt'
              }
            ],
            template_id: 'XXX-YYY-ZZZ',
            sections: { 'sectionkey' => 'セクション置換' },
            headers: { 'X-GLOBAL' => 'GLOBAL_VALUE' },
            categories: %w(CAT1 CAT2),
            custom_args: { 'CUSTOM1' => 'CUSTOM_VALUE1' },
            send_at: 1451606400,
            batch_id: '1234567890',
            asm: { group_id: 3581, groups_to_display: [12, 34] },
            ip_pool_name: 'pool_name',
            mail_settings: {},
            tracking_settings: {}
          )
        end
      end
    end
  end
end
