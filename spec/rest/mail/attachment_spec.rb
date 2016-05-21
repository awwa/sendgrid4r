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
          attachment = SendGrid4r::Factory::MailFactory.create_attachment(
            content: 'Hello', filename: 'example.txt'
          )
          expect(attachment.to_h).to eq(
            content: 'SGVsbG8=', filename: 'example.txt'
          )
        end

        it '#to_h with full parameters' do
          attachment = SendGrid4r::Factory::MailFactory.create_attachment(
            content: 'Hello', filename: 'example.txt'
          )
          attachment.content = 'MoMoMo'
          attachment.filename = 'new.txt'
          attachment.type = 'text/csv'
          attachment.disposition = 'inline'
          attachment.content_id = 'ii_139db99fdb5c3704'
          expect(attachment.to_h).to eq(
            content: 'TW9Nb01v',
            filename: 'new.txt',
            type: 'text/csv',
            disposition: 'inline',
            content_id: 'ii_139db99fdb5c3704'
          )
        end
      end
    end
  end
end
