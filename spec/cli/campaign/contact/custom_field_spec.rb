# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::CLI::Campaign::Contact
  describe CustomField do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--name', 'cli_test',
          '--type', 'text'
        ]
        CustomField.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        CustomField.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--custom-field-id', 112801
        ]
        CustomField.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['API_KEY'],
          '--custom-field-id', 112801
        ]
        CustomField.start(args)
      end
    end
  end
end
