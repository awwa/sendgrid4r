# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::CancelSchedules
  describe BatchId do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#generate' do
        args = [
          'generate',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        BatchId.start(args)
      end

      it '#validate' do
        args = [
          'validate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--batch-id', 'NWI4NjAwZWMtMzNjYS0xMWU2LTgxYzktNTI1NDAwYTUxOTdhLTc4ZmZiMGNmMg'
        ]
        BatchId.start(args)
      end
    end
  end
end
