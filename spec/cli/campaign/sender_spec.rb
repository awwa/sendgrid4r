# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Campaign
  describe Sender do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--nickname', 'cli_sender',
          '--from', 'email:from@abc.abc', 'name:from_name',
          '--reply-to', 'email:reply_to@abc.abc', 'name:reply_to_name',
          '--address', 'Address',
          '--address-2', 'Address2',
          '--city', 'City',
          '--state', 'State',
          '--zip', 'Zip',
          '--country', 'Country'
        ]
        Sender.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        Sender.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['API_KEY'],
          '--sender-id', 41280,
          '--nickname', 'cli_sender_edit',
          '--from', 'email:from_edit@abc.abc', 'name:from_name_edit',
          '--reply-to', 'email:reply_to_edit@abc.abc',
          'name:reply_to_name_edit',
          '--address', 'Address_edit',
          '--address-2', 'Address2_edit',
          '--city', 'City_edit',
          '--state', 'State_edit',
          '--zip', 'Zip_edit',
          '--country', 'Country_edit'
        ]
        Sender.start(args)
      end

      it '#verify' do
        args = [
          'verify',
          '--api-key', ENV['API_KEY'],
          '--sender-id', 41280
        ]
        Sender.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--sender-id', 41280
        ]
        Sender.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['API_KEY'],
          '--sender-id', 41280
        ]
        Sender.start(args)
      end
    end
  end
end
