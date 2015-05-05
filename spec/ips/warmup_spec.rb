# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Ips::Warmup do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(
        username: ENV['SILVER_SENDGRID_USERNAME'],
        password: ENV['SILVER_SENDGRID_PASSWORD'])
    end

    context 'account is silver' do
      before do
        begin
          # celan up test env
          warmup_ips = @client.get_warmup_ips
          if warmup_ips.length > 0
            warmup_ips.each do |warmup_ip|
              @client.delete_warmup_ip(warmup_ip.ip)
            end
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      context 'without block call' do
        it 'warmup_ip spec' do
          begin
            # get warmup ip
            warmup_ips = @client.get_warmup_ips
            expect(warmup_ips.length).to eq(0)
            # post warmup ip
            ips = @client.get_ips
            expect(ips.length).to be > 0
            warmup_ip = @client.post_warmup_ip(ips[0].ip)
            expect(warmup_ip.ip).to eq(ips[0].ip)
            warmup_ip = @client.get_warmup_ip(warmup_ip.ip)
            expect(warmup_ip.ip).to eq(ips[0].ip)
            # delete the warmup ip
            @client.delete_warmup_ip(warmup_ip.ip)
            expect do
              @client.get_warmup_ip(warmup_ip.ip)
            end.to raise_error(RestClient::ResourceNotFound)
          rescue => ex
            puts ex.inspect
            raise ex
          end
        end
      end

      context 'with block call' do
        it 'warmup_ip spec' do
          # get warmup ips
          @client.get_warmup_ips do |resp, req, res|
            resp =
              SendGrid4r::REST::Ips::Warmup.create_warmup_ips(
                JSON.parse(resp)
              )
            expect(resp).to be_a(Array)
            expect(req).to be_a(RestClient::Request)
            expect(res).to be_a(Net::HTTPOK)
          end
          # post warmup ip
          warmup_ip = nil
          ips = @client.get_ips
          expect(ips.length).to be > 0
          @client.post_warmup_ip(ips[0].ip) do |resp, req, res|
            resp =
              SendGrid4r::REST::Ips::Warmup.create_warmup_ip(
                JSON.parse(resp)
              )
            warmup_ip = resp
            expect(resp).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
            expect(req).to be_a(RestClient::Request)
            expect(res).to be_a(Net::HTTPCreated)
          end
          # get warmup ip
          @client.get_warmup_ip(warmup_ip.ip) do |resp, req, res|
            resp =
              SendGrid4r::REST::Ips::Warmup.create_warmup_ip(
                JSON.parse(resp)
              )
            expect(resp).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
            expect(req).to be_a(RestClient::Request)
            expect(res).to be_a(Net::HTTPOK)
          end
          # delete the warmup ip
          @client.delete_warmup_ip(warmup_ip.ip) do |resp, req, res|
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

    let(:warmup_ip) do
      JSON.parse(
        '{'\
          '"ip":"0.0.0.0",'\
          '"start_date":1409616000'\
        '}'
      )
    end

    let(:warmup_ips) do
      JSON.parse(
        '['\
          '{'\
            '"ip": "0.0.0.0",'\
            '"start_date": 1409616000'\
          '}'\
        ']'
      )
    end

    it '#get_warmup_ips' do
      allow(client).to receive(:execute).and_return(warmup_ips)
      actual = client.get_warmup_ips
      expect(actual).to be_a(Array)
      actual.each do |warmup_ip|
        expect(warmup_ip).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
      end
    end

    it '#get_warmup_ip' do
      allow(client).to receive(:execute).and_return(warmup_ip)
      actual = client.get_warmup_ip('')
      expect(actual).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
    end

    it '#post_warmup_ip' do
      allow(client).to receive(:execute).and_return(warmup_ip)
      actual = client.post_warmup_ip('')
      expect(actual).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
    end

    it '#delete_warmup_ip' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_warmup_ip('')
      expect(actual).to eq('')
    end

    it 'creates warmup_ips instance' do
      actual = SendGrid4r::REST::Ips::Warmup.create_warmup_ips(warmup_ips)
      expect(actual).to be_a(Array)
      actual.each do |warmup_ip|
        expect(warmup_ip).to be_a(SendGrid4r::REST::Ips::Warmup::WarmupIp)
        expect(warmup_ip.ip).to eq('0.0.0.0')
        expect(warmup_ip.start_date).to eq(Time.at(1409616000))
      end
    end
  end
end
