# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Settings
  describe EnforcedTls do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#get' do
        args = [
          'get',
          '--apikey', ENV['SILVER_API_KEY']
        ]
        EnforcedTls.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--apikey', ENV['SILVER_API_KEY'],
          '--require_tls', true,
          '--require_valid_cert', true
        ]
        EnforcedTls.start(args)
      end
    end
  end
end
