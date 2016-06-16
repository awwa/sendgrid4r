# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe InvalidEmail do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY'],
          '--start-time', Time.local(2016, 1, 1).to_i,
          '--end-time', Time.local(2016, 1, 31).to_i,
          '--limit', 10,
          '--offset', 0
        ]
        InvalidEmail.start(args)
      end

      it '#delete with delete_all' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--delete-all', true
        ]
        InvalidEmail.start(args)
      end

      it '#delete with email' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', 'abc@abc.com'
        ]
        InvalidEmail.start(args)
      end

      it '#delete with emails' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--emails', 'abc@abc.com', 'cde@cde.com'
        ]
        InvalidEmail.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--email', 'abc@abc.com'
        ]
        InvalidEmail.start(args)
      end
    end
  end
end
