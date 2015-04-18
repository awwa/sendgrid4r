# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Asm do
  context 'unit test' do
    it 'creates recipient_emails instance' do
      json =
        '{'\
          '"recipient_emails": ['\
            '"test1@example.com",'\
            '"test2@example.com"'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Asm.create_recipient_emails(hash)
      expect(actual.recipient_emails).to be_a(Array)
    end

    it 'creates recipient_email instance' do
      json =
        '{'\
          '"recipient_email": "test1@example.com"'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Asm.create_recipient_email(hash)
      expect(actual.recipient_email).to eq('test1@example.com')
    end
  end
end
