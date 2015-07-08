# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Ips::Addresses do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
    end

    context 'account is free' do
      describe '#get_ip' do
        it 'raise error' do
          begin
            expect do
              @client.get_ip(ip: '10.10.10.10').to raise_error(
                RestClient::Forbidden
              )
            end
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end
      end
    end

    context 'account is silver' do
      TEST_POOL = 'test_pool'

      before do
        begin
          @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
          # refresh the pool
          pools = @client.get_pools
          pools.each do |pool|
            @client.delete_pool(name: TEST_POOL) if pool.name == TEST_POOL
          end
          @client.post_pool(name: TEST_POOL)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      context 'without block call' do
        it '#get_ips' do
          begin
            ips = @client.get_ips
            expect(ips.length).to be > 0
            ip = ips[0]
            expect(ip).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
            expect(ip.ip).to be_a(String)
            expect(ip.pools).to be_a(Array)
            expect(ip.warmup ? true : true).to eq(true)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end

        it '#get_ips_assigned' do
          begin
            ips = @client.get_ips_assigned
            expect(ips.length).to be > 0
            expect(ips[0]).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end

        it '#get_ip' do
          begin
            ips = @client.get_ips_assigned
            expect(
              @client.get_ip(ip: ips[0].ip)
            ).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end

        it '#post_ip_to_pool' do
          begin
            ips = @client.get_ips_assigned
            actual = @client.post_ip_to_pool(
              pool_name: TEST_POOL, ip: ips[0].ip
            )
            expect(actual.ip).to eq(ips[0].ip)
            expect(actual.pools).to include(TEST_POOL)
            expect(actual.pools).to be_a(Array)
            @client.delete_ip_from_pool(pool_name: TEST_POOL, ip: ips[0].ip)
          rescue RestClient::ExceptionWithResponse => e
            puts e.inspect
            raise e
          end
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:address) do
        JSON.parse(
          '{'\
            '"ip": "000.00.00.0",'\
            '"pools": ['\
              '"test1"'\
            '],'\
            '"start_date": 1409616000,'\
            '"warmup": true'\
          '}'
        )
      end

      let(:addresses) do
        JSON.parse(
          '['\
            '{'\
              '"ip":"000.00.00.0",'\
              '"pools":["new_test5"],'\
              '"warmup":true,'\
              '"start_date":1409616000,'\
              '"subusers": ["username1", "username2"],'\
              '"rdns": "01.email.test.com",'\
              '"pools": ["pool1", "pool2"]'\
            '}'\
          ']'
        )
      end

      it '#get_ips' do
        allow(client).to receive(:execute).and_return(addresses)
        actual = client.get_ips
        expect(actual).to be_a(Array)
        actual.each do |address|
          expect(address).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        end
      end

      it '#get_ips_assigned' do
        allow(client).to receive(:execute).and_return(addresses)
        actual = client.get_ips_assigned
        expect(actual).to be_a(Array)
        actual.each do |address|
          expect(address).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        end
      end

      it '#get_ip' do
        allow(client).to receive(:execute).and_return(address)
        actual = client.get_ip(ip: '')
        expect(actual).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
      end

      it '#post_ip_to_pool' do
        allow(client).to receive(:execute).and_return(address)
        actual = client.post_ip_to_pool(pool_name: '', ip: '')
        expect(actual).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
      end

      it 'creates addresses instance' do
        actual = SendGrid4r::REST::Ips::Addresses.create_addresses(addresses)
        expect(actual).to be_a(Array)
        actual.each do |address|
          expect(
            address
          ).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        end
      end

      it 'creates address instance' do
        actual = SendGrid4r::REST::Ips::Addresses.create_address(address)
        expect(actual).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        expect(actual.ip).to eq('000.00.00.0')
        expect(actual.pools).to be_a(Array)
        actual.pools.each do |pool|
          expect(pool).to eq('test1')
        end
        expect(actual.start_date).to eq(Time.at(1409616000))
        expect(actual.warmup).to eq(true)
      end
    end
  end
end
