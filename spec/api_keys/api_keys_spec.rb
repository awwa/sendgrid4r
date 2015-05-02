# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::ApiKeys do
  describe 'integration test' do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @name1 = 'api_key_name1'
        @name2 = 'api_key_name2'
        @name1e = 'api_key_name1_edit'

        # celan up test env(lists)
        api_keys = @client.get_api_keys
        api_keys.result.each do |api_key|
          @client.delete_api_key(api_key.api_key_id) if api_key.name == @name1
          @client.delete_api_key(api_key.api_key_id) if api_key.name == @name2
          @client.delete_api_key(api_key.api_key_id) if api_key.name == @name1e
        end

        # post api_key
        @api_key1 = @client.post_api_key(@name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_api_keys' do
        begin
          api_keys = @client.get_api_keys
          expect(api_keys).to be_a(SendGrid4r::REST::ApiKeys::ApiKeys)
          expect(api_keys.result).to be_a(Array)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#post_api_key' do
        begin
          api_key2 = @client.post_api_key(@name2)
          expect(api_key2).to be_a(SendGrid4r::REST::ApiKeys::ApiKey)
          expect(api_key2.name).to eq(@name2)
          expect(api_key2.api_key_id).to be_a(String)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_api_key' do
        begin
          @client.delete_api_key(@api_key1.api_key_id)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_api_key' do
        begin
          edit_api_key = @client.patch_api_key(@api_key1.api_key_id, @name1e)
          expect(edit_api_key.api_key_id).to eq(@api_key1.api_key_id)
          expect(edit_api_key.name).to eq(@name1e)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_api_keys' do
        @client.get_api_keys do |resp, req, res|
          resp =
            SendGrid4r::REST::ApiKeys.create_api_keys(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::ApiKeys::ApiKeys)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#post_api_key' do
        @client.post_api_key(@name2) do |resp, req, res|
          resp =
            SendGrid4r::REST::ApiKeys.create_api_key(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::ApiKeys::ApiKey)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#delete_api_key' do
        @client.delete_api_key(@api_key1.api_key_id) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end

      it '#patch_api_key' do
        @client.patch_api_key(@api_key1.api_key_id, @name1e) do |resp, req, res|
          resp =
            SendGrid4r::REST::ApiKeys.create_api_key(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::ApiKeys::ApiKey)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end
    end
  end

  describe 'unit test' do
    it 'creates api_key instance' do
      json =
        '{'\
          '"api_key_id": "qfTQ6KG0QBiwWdJ0-pCLCA",'\
          '"name": "A New Hope"'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::ApiKeys.create_api_key(hash)
      expect(actual).to be_a(SendGrid4r::REST::ApiKeys::ApiKey)
      expect(actual.api_key_id).to eq('qfTQ6KG0QBiwWdJ0-pCLCA')
      expect(actual.name).to eq('A New Hope')
    end

    it 'creates api_keys instance' do
      json =
        '{'\
          '"result": ['\
            '{'\
              '"name": "A New Hope",'\
              '"api_key_id": "xxxxxxxx"'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::ApiKeys.create_api_keys(hash)
      expect(actual).to be_a(SendGrid4r::REST::ApiKeys::ApiKeys)
      expect(actual.result).to be_a(Array)
      actual.result.each do |api_key|
        expect(api_key.name).to eq('A New Hope')
        expect(api_key.api_key_id).to eq('xxxxxxxx')
      end
    end
  end
end
