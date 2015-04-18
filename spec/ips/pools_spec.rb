# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Ips::Pools do
  before do
    begin
      Dotenv.load
      @client = SendGrid4r::Client.new(
        ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
      @pool_name1 = 'pool_test1'
      @pool_name2 = 'pool_test2'
      @pool_edit1 = 'pool_edit1'

      # clean up test env
      pools = @client.get_pools
      pools.each do |pool|
        @client.delete_pool(pool.name) if pool.name == @pool_name1
        @client.delete_pool(pool.name) if pool.name == @pool_name2
        @client.delete_pool(pool.name) if pool.name == @pool_edit1
      end
      # post a pool
      @client.post_pool(@pool_name1)
    rescue => e
      puts e.inspect
      raise e
    end
  end

  context 'account is silver' do
    context 'without block call' do
      it '#post_pool' do
        begin
          new_pool = @client.post_pool(@pool_name2)
          expect(@pool_name2).to eq(new_pool.name)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_pools' do
        begin
          pools = @client.get_pools
          expect(pools.length).to be > 0
          pools.each do |pool|
            expect(pool).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
            expect(pool.name).to be_a(String)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_pool' do
        begin
          pool = @client.get_pool(@pool_name1)
          expect(pool).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
          expect(pool.pool_name).to eq(@pool_name1)
          expect(pool.ips).to be_a(Array)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#put_pool' do
        begin
          edit_pool = @client.put_pool(@pool_name1, @pool_edit1)
          expect(@pool_edit1).to eq(edit_pool.name)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_pool' do
        begin
          @client.delete_pool(@pool_name1)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#post_pool' do
        @client.post_pool(@pool_name2) do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Pools.create_pool(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#get_pools' do
        @client.get_pools do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Pools.create_pools(
              JSON.parse(resp)
            )
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_pool' do
        @client.get_pool(@pool_name1) do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Pools.create_pool(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#put_pool' do
        @client.put_pool(@pool_name1, @pool_edit1) do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Pools.create_pool(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_pool' do
        @client.delete_pool(@pool_name1) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end

    it 'creates pool instance' do
      json = '{"name":"marketing"}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Ips::Pools.create_pool(hash)
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
    end

    it 'creates pool instance with ips' do
      json =
        '{'\
          '"ips":["167.89.21.3"],'\
          '"name":"new_test5"'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Ips::Pools.create_pool(hash)
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
    end

    it 'creates pool instances' do
      json =
        '['\
          '{'\
            '"name": "test1"'\
          '},'\
          '{'\
            '"name": "test2"'\
          '},'\
          '{'\
            '"name": "test3"'\
          '},'\
          '{'\
            '"name": "new_test3"'\
          '}'\
        ']'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Ips::Pools.create_pools(hash)
      expect(actual).to be_a(Array)
      actual.each do |pool|
        expect(pool).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
      end
    end
  end
end
