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
          em = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['MAIL']
          )
          expect(em.to_h).to eq(email: ENV['MAIL'])
        end

        it '#to_h with full parameters' do
          em = SendGrid4r::Factory::MailFactory.create_address(
            email: ENV['MAIL'], name: 'To name'
          )
          em.email = ENV['FROM']
          em.name = 'To name2'
          expect(em.to_h).to eq(email: ENV['FROM'], name: 'To name2')
        end
      end
    end
  end
end
