# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::CancelSchedules
  describe CancelSchedule do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#add' do
        args = [
          'add',
          '--apikey', ENV['SILVER_API_KEY'],
          '--batch_id', 'NWI4NjAwZWMtMzNjYS0xMWU2LTgxYzktNTI1NDAwYTUxOTdhLTc4ZmZiMGNmMg',
          '--status', 'cancel'
        ]
        CancelSchedule.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        CancelSchedule.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY'],
          '--batch_id', 'NWI4NjAwZWMtMzNjYS0xMWU2LTgxYzktNTI1NDAwYTUxOTdhLTc4ZmZiMGNmMg'
        ]
        CancelSchedule.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--batch_id', 'NWI4NjAwZWMtMzNjYS0xMWU2LTgxYzktNTI1NDAwYTUxOTdhLTc4ZmZiMGNmMg',
          '--status', 'pause'
        ]
        CancelSchedule.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--apikey', ENV['SILVER_API_KEY'],
          '--batch_id', 'NWI4NjAwZWMtMzNjYS0xMWU2LTgxYzktNTI1NDAwYTUxOTdhLTc4ZmZiMGNmMg'
        ]
        CancelSchedule.start(args)
      end

      it '#batch_id subcommand' do
        args = [
          'batch_id'
        ]
        CancelSchedule.start(args)
      end
    end
  end
end
