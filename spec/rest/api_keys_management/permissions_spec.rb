# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::ApiKeysManagement
  describe Permissions do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#get_permissions' do
          permissions = @client.get_permissions
          expect(permissions).to be_a(Permissions::Permissions)
          expect(permissions.scopes).to be_a(Array)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:permissions) do
        JSON.parse(
          '{'\
            '"scopes": ['\
              '"alerts.create",'\
              '"alerts.read",'\
              '"alerts.update"'\
            ']'\
          '}'
        )
      end

      it '#get_permissions' do
        allow(client).to receive(:execute).and_return(permissions)
        actual = client.get_permissions
        expect(actual).to be_a(Permissions::Permissions)
      end

      it 'creates permissions instance' do
        actual = Permissions.create_permissions(
          permissions
        )
        expect(actual).to be_a(Permissions::Permissions)
        expect(actual.scopes).to be_a(Array)
        expect(actual.scopes[0]).to eq('alerts.create')
        expect(actual.scopes[1]).to eq('alerts.read')
        expect(actual.scopes[2]).to eq('alerts.update')
      end
    end
  end
end
