# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Templates
  describe Template do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--name', 'cli_template'
        ]
        Template.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Template.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4'
        ]
        Template.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 'a973204f-2fcc-419d-8f04-db4a3f5fe01e',
          '--name', 'cli_template_edit'
        ]
        Template.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--id', 'a973204f-2fcc-419d-8f04-db4a3f5fe01e'
        ]
        Template.start(args)
      end

      it '#version subcommand' do
        args = [
          'version',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Template.start(args)
      end
    end
  end
end
