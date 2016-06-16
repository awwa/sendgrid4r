# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Sm
  describe SendGrid4r::REST::Sm do
    let(:recipient_email) do
      '{'\
        '"recipient_email": "test1@example.com"'\
      '}'
    end

    let(:recipient_emails) do
      '{'\
        '"recipient_emails": ['\
          '"test1@example.com",'\
          '"test2@example.com"'\
        ']'\
      '}'
    end

    describe 'unit test', :ut do
      it 'creates recipient_emails instance' do
        actual = SendGrid4r::REST::Sm.create_recipient_emails(
          JSON.parse(recipient_emails)
        )
        expect(actual).to be_a(RecipientEmails)
        expect(actual.recipient_emails).to be_a(Array)
        expect(actual.recipient_emails).to include('test1@example.com')
        expect(actual.recipient_emails).to include('test2@example.com')
      end

      it 'creates recipient_email instance' do
        actual = SendGrid4r::REST::Sm.create_recipient_email(
          JSON.parse(recipient_email)
        )
        expect(actual).to be_a(RecipientEmail)
        expect(actual.recipient_email).to eq('test1@example.com')
      end
    end
  end
end
