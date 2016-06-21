# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::CLI::Campaign::Contact
  describe List do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--name', 'cli_list'
        ]
        List.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        List.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--list-id', 402704
        ]
        List.start(args)
      end

      it '#rename' do
        args = [
          'rename',
          '--api-key', ENV['API_KEY'],
          '--list-id', 402704,
          '--name', 'cli_list_edit'
        ]
        List.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['API_KEY'],
          '--list-id', 402704
        ]
        List.start(args)
      end

      it '#recipient with add action' do
        args = [
          'recipient', 'add',
          '--api-key', ENV['API_KEY'],
          '--list-id', 402704,
          '--recipients', 'YXd3YTUwMEBnbWFpbC5jb20='
        ]
        List.start(args)
      end

      it '#recipient with list action' do
        args = [
          'recipient', 'list',
          '--api-key', ENV['API_KEY'],
          '--list-id', 405165,
          '--page', 1,
          '--page-size', 20
        ]
        List.start(args)
      end

      it '#recipient with remove action' do
        args = [
          'recipient', 'remove',
          '--api-key', ENV['API_KEY'],
          '--list-id', 402704,
          '--recipient-id', 'YWJjQGFiYy5hYmM='
        ]
        List.start(args)
      end
    end
  end
end
