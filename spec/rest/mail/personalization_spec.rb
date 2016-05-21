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
          email: ENV['MAIL']
        )
      end

      let(:cc) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: ENV['CC']
        )
      end

      let(:bcc) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: ENV['BCC']
        )
      end

      context 'without block call' do
        it '#to_h with mandatory parameters' do
          per = SendGrid4r::Factory::MailFactory.create_personalization(
            to: [to], subject: 'This is subject.'
          )
          expect(per.to_h).to eq(
            to: [{ email: ENV['MAIL'] }], subject: 'This is subject.'
          )
        end

        it '#to_h with full parameters' do
          per = SendGrid4r::Factory::MailFactory.create_personalization(
            to: [to], subject: 'This is subject.'
          )
          per.cc = [cc]
          per.bcc = [bcc]
          per.headers = { 'X-CUSTOM' => 'X-VALUE' }
          per.substitutions = {
            'subkey' => '置換値', 'sectionkey' => 'sectionkey'
          }
          per.custom_args = { 'CUSTOM' => 'value' }
          per.send_at = Time.utc(2016)
          expect(per.to_h).to eq(
            to: [{ email: ENV['MAIL'] }], subject: 'This is subject.',
            cc: [{ email: ENV['CC'] }], bcc: [{ email: ENV['BCC'] }],
            headers: { 'X-CUSTOM' => 'X-VALUE' },
            substitutions: {
              'subkey' => '置換値', 'sectionkey' => 'sectionkey'
            },
            custom_args: { 'CUSTOM' => 'value' },
            send_at: 1451606400
          )
        end
      end
    end
  end
end
