# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Webhooks
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['SILVER_API_KEY']
        ]
        Parse.start(args)
      end
    end
  end
end
