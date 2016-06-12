# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Suppressions
  describe Parse do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        Parse.start(args)
      end
    end
  end
end
