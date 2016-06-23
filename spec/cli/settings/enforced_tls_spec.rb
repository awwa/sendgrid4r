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
          '--api-key', ENV['SILVER_API_KEY']
        ]
        EnforcedTls.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['SILVER_API_KEY'],
          '--require-tls', true,
          '--require-valid-cert', true
        ]
        EnforcedTls.start(args)
      end
    end
  end
end
