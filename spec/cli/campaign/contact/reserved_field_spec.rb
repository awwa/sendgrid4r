# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::CLI::Campaign::Contact
  describe ReservedField do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        ReservedField.start(args)
      end
    end
  end
end
