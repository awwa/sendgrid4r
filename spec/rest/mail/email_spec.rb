# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST
  describe Mail do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      context 'without block call' do
        it '#to_h with full parameters' do
          to = SendGrid4r::Factory::MailFactory.create_email(
            email: ENV['MAIL'], name: 'To name'
          )
          expect(to.to_h).to eq({ email: ENV['MAIL'], name: 'To name' })
        end

        it '#to_h with mandatory parameters' do
          to = SendGrid4r::Factory::MailFactory.create_email(
            email: ENV['MAIL']
          )
          expect(to.to_h).to eq({ email: ENV['MAIL'] })
        end
      end
    end
  end
end
