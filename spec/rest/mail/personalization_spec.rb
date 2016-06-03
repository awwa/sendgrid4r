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

      let(:cc) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: 'cc@example.com'
        )
      end

      let(:bcc) do
        SendGrid4r::Factory::MailFactory.create_address(
          email: 'bcc@example.com'
        )
      end

      it '#to_h with mandatory parameters' do
        per = SendGrid4r::Factory::MailFactory.create_personalization(
          to: [to]
        )
        expect(per.to_h).to eq(
          to: [{ email: 'to@example.com' }]
        )
      end

      it '#to_h with full parameters' do
        per = SendGrid4r::Factory::MailFactory.create_personalization(
          to: [to]
        )
        per.subject = 'This is subject.'
        per.cc = [cc]
        per.bcc = [bcc]
        per.headers = { 'X-CUSTOM' => 'X-VALUE' }
        per.substitutions = {
          'subkey' => 'subval', 'sectionkey' => 'sectionkey'
        }
        per.custom_args = { 'CUSTOM' => 'value' }
        per.send_at = Time.utc(2016)
        expect(per.to_h).to eq(
          to: [{ email: 'to@example.com' }],
          subject: 'This is subject.',
          cc: [{ email: 'cc@example.com' }],
          bcc: [{ email: 'bcc@example.com' }],
          headers: { 'X-CUSTOM' => 'X-VALUE' },
          substitutions: {
            'subkey' => 'subval', 'sectionkey' => 'sectionkey'
          },
          custom_args: { 'CUSTOM' => 'value' },
          send_at: 1451606400
        )
      end
    end
  end
end
