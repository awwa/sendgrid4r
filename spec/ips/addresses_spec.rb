# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Ips::Addresses' do
  before :all do
    Dotenv.load
  end

  context 'account is free' do
    before :all do
      @client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    end

    describe '#get_ip' do
      it 'raise error' do
        begin
          expect do
            @client.get_ip('10.10.10.10').to raise_error(RestClient::Forbidden)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end
  end

  context 'account is silver' do
    TEST_POOL = 'test_pool'

    context 'without block call' do
      before :all do
        begin
          @client = SendGrid4r::Client.new(
            ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
          # refresh the pool
          pools = @client.get_pools
          pools.each do |pool|
            @client.delete_pool(TEST_POOL) if pool.name == TEST_POOL
          end
          @client.post_pool(TEST_POOL)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_ips' do
        begin
          ips = @client.get_ips
          expect(ips.length).to be > 0
          ip = ips[0]
          expect(ip.class).to be(SendGrid4r::REST::Ips::Addresses::Address)
          expect(ip.ip).to be_a(String)
          expect(ip.pools).to be_a(Array)
          expect(ip.warmup ? true : true).to eq(true)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_ips_assigned' do
        begin
          ips = @client.get_ips_assigned
          expect(ips.length).to be > 0
          expect(ips[0]).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_ip' do
        begin
          ips = @client.get_ips_assigned
          expect(
            @client.get_ip(ips[0].ip)
          ).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#post_ip_to_pool' do
        begin
          ips = @client.get_ips_assigned
          actual = @client.post_ip_to_pool(TEST_POOL, ips[0].ip)
          expect(actual.ip).to eq(ips[0].ip)
          expect(actual.pools).to include(TEST_POOL)
          expect(actual.pools).to be_a(Array)
          @client.delete_ip_from_pool(TEST_POOL, ips[0].ip)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      before :all do
        begin
          @client = SendGrid4r::Client.new(
            ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
          # refresh the pool
          pools = @client.get_pools
          pools.each do |pool|
            @client.delete_pool(TEST_POOL) if pool.name == TEST_POOL
          end
          @client.post_pool(TEST_POOL)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_ips' do
        @client.get_ips do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Addresses.create_addresses(
              JSON.parse(resp)
            )
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_ips_assigned' do
        @client.get_ips_assigned do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Addresses.create_addresses(
              JSON.parse(resp)
            )
          expect(resp).to be_a(Array)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_ip' do
        ips = @client.get_ips_assigned
        @client.get_ip(ips[0].ip) do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Addresses.create_address(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#post_ip_to_pool' do
        ips = @client.get_ips_assigned
        @client.post_ip_to_pool(TEST_POOL, ips[0].ip) do |resp, req, res|
          resp =
            SendGrid4r::REST::Ips::Addresses.create_address(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
        @client.delete_ip_from_pool(TEST_POOL, ips[0].ip) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end

    it 'creates addresses instance' do
      json =
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
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Ips::Addresses.create_addresses(hash)
      expect(actual).to be_a(Array)
      actual.each do |address|
        expect(
          address
        ).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
      end
    end

    it 'creates address instance' do
      json =
        '{'\
          '"ip": "000.00.00.0",'\
          '"pools": ['\
            '"test1"'\
          '],'\
          '"start_date": 1409616000,'\
          '"warmup": true'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Ips::Addresses.create_address(hash)
      expect(actual).to be_a(SendGrid4r::REST::Ips::Addresses::Address)
    end
  end
end
