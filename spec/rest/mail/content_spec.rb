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
          content = SendGrid4r::Factory::MailFactory.create_content(
            type: 'text/plain', value: 'This is text part.'
          )
          expect(content.to_h).to eq(
            type: 'text/plain', value: 'This is text part.'
          )
        end

        it '#to_h with full parameters' do
          content = SendGrid4r::Factory::MailFactory.create_content(
            type: 'text/plain', value: 'This is text part.'
          )
          content.type = 'text/html'
          content.value = '<div>This is html part.</div>'
          expect(content.to_h).to eq(
            type: 'text/html', value: '<div>This is html part.</div>'
          )
        end
      end
    end
  end
end
