# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Templates
  describe Version do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['SILVER_API_KEY'],
          '--template-id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4',
          '--name', 'cli_version',
          '--subject', 'Hello!<%subject%>',
          '--html-content', 'HTML_Content<%body%>',
          '--plain-content', 'plain_content<%body%>',
          '--active', 0
        ]
        Version.start(args)
      end

      it '#activate' do
        args = [
          'activate',
          '--api-key', ENV['SILVER_API_KEY'],
          '--template-id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4',
          '--version-id', '811fbaad-9079-4f5c-8c3c-3582a7c100c7'
        ]
        Version.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY'],
          '--template-id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4',
          '--version-id', '594a5aef-dbf4-4e27-8bc1-ef3242c96b89'
        ]
        Version.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--template-id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4',
          '--version-id', '594a5aef-dbf4-4e27-8bc1-ef3242c96b89',
          '--name', 'cli_version_edit',
          '--subject', 'Hello!<%subject%> edit',
          '--html-content', 'HTML_Content<%body%> edit',
          '--plain-content', 'plain_content<%body%> edit',
          '--active', 1
        ]
        Version.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['SILVER_API_KEY'],
          '--template-id', 'b4c57fdc-4ae3-451f-9f09-56bedd4ec6c4',
          '--version-id', '594a5aef-dbf4-4e27-8bc1-ef3242c96b89'
        ]
        Version.start(args)
      end
    end
  end
end
