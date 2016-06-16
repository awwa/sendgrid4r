# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::CLI
  describe Category do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list with full params' do
        args = [
          'list',
          '--api_key', ENV['SILVER_API_KEY'],
          '--category', 'en',
          '--limit', 2,
          '--offset', 0
        ]
        Category.start(args)
      end
    end
  end
end
