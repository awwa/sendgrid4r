# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Ips::Pools do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          username: ENV['SILVER_SENDGRID_USERNAME'],
          password: ENV['SILVER_SENDGRID_PASSWORD'])

        @pool_name1 = 'pool_test1'
        @pool_name2 = 'pool_test2'
        @pool_edit1 = 'pool_edit1'

        # clean up test env
        pools = @client.get_pools
        pools.each do |pool|
          @client.delete_pool(name: pool.name) if pool.name == @pool_name1
          @client.delete_pool(name: pool.name) if pool.name == @pool_name2
          @client.delete_pool(name: pool.name) if pool.name == @pool_edit1
        end
        # post a pool
        @client.post_pool(name: @pool_name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'account is silver' do
      context 'without block call' do
        it '#post_pool' do
          begin
            new_pool = @client.post_pool(name: @pool_name2)
            expect(new_pool.name).to eq(@pool_name2)
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
            pool = @client.get_pool(name: @pool_name1)
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
            edit_pool = @client.put_pool(
              name: @pool_name1, new_name: @pool_edit1
            )
            expect(edit_pool.name).to eq(@pool_edit1)
          rescue => e
            puts e.inspect
            raise e
          end
        end

        it '#delete_pool' do
          begin
            @client.delete_pool(name: @pool_name1)
          rescue => e
            puts e.inspect
            raise e
          end
        end
      end

      context 'with block call' do
        it '#post_pool' do
          @client.post_pool(name: @pool_name2) do |resp, req, res|
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
          @client.get_pool(name: @pool_name1) do |resp, req, res|
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
          @client.put_pool(
            name: @pool_name1, new_name: @pool_edit1
          ) do |resp, req, res|
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
          @client.delete_pool(name: @pool_name1) do |resp, req, res|
            expect(resp).to eq('')
            expect(req).to be_a(RestClient::Request)
            expect(res).to be_a(Net::HTTPNoContent)
          end
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:pool) do
      JSON.parse(
        '{'\
          '"ips":["167.89.21.3"],'\
          '"name":"new_test5"'\
        '}'
      )
    end

    let(:pools) do
      JSON.parse(
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
      )
    end

    it '#post_pool' do
      allow(client).to receive(:execute).and_return(pool)
      actual = client.post_pool(name: '')
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
    end

    it '#get_pools' do
      allow(client).to receive(:execute).and_return(pools)
      actual = client.get_pools
      expect(actual).to be_a(Array)
      actual.each do |pool|
        expect(pool).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
      end
    end

    it '#get_pool' do
      allow(client).to receive(:execute).and_return(pool)
      actual = client.get_pool(name: '')
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
    end

    it '#put_pool' do
      allow(client).to receive(:execute).and_return(pool)
      actual = client.put_pool(name: '', new_name: '')
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
    end

    it '#delete_pool' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_pool(name: '')
      expect(actual).to eq('')
    end

    it 'creates pool instance with ips' do
      actual = SendGrid4r::REST::Ips::Pools.create_pool(pool)
      expect(actual).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
      expect(actual.ips).to be_a(Array)
      actual.ips.each do |ip|
        expect(ip).to eq('167.89.21.3')
      end
      expect(actual.name).to eq('new_test5')
    end

    it 'creates pools instances' do
      actual = SendGrid4r::REST::Ips::Pools.create_pools(pools)
      expect(actual).to be_a(Array)
      actual.each do |pool|
        expect(pool).to be_a(SendGrid4r::REST::Ips::Pools::Pool)
      end
    end
  end
end
