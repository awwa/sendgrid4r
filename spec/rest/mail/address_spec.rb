# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST
  describe Mail do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it '#to_h with mandatory parameters' do
        em = SendGrid4r::Factory::MailFactory.create_address(
          email: 'test@example.com'
        )
        expect(em.to_h).to eq(email: 'test@example.com')
      end

      it '#to_h with full parameters' do
        em = SendGrid4r::Factory::MailFactory.create_address(
          email: 'test@example.com', name: 'To name'
        )
        em.email = 'from@example.com'
        em.name = 'To name2'
        expect(em.to_h).to eq(email: 'from@example.com', name: 'To name2')
      end
    end
  end
end
