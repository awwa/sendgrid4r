# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Whitelabel::Ips do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @subdomain_name = ENV['SUBDOMAIN_IP']
        @domain_name = ENV['DOMAIN']
        @username = ENV['USERNAME']
        @ip = ENV['IP']

        # celan up test env(lists)
        ips = @client.get_wl_ips
        ips.each do |ip|
          @client.delete_wl_ip(
            id: ip.id
          ) if ip.subdomain == @subdomain_name && ip.domain == @domain_name
        end

        @ipw = @client.post_wl_ip(
          ip: @ip, subdomain: @subdomain_name, domain: @domain_name
        )

      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_wl_ips' do
        begin
          ips = @client.get_wl_ips
          expect(ips).to be_a(Array)
          ips.each do |ip|
            expect(ip).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#post_wl_ip' do
        begin
          expect(@ipw).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
          expect(@ipw.id).to be_a(Numeric)
          expect(@ipw.ip).to eq(@ip)
          expect(@ipw.rdns).to be_a(String)
          expect(@ipw.users).to be_a(Array)
          expect(@ipw.subdomain).to eq(@subdomain_name)
          expect(@ipw.domain).to eq(@domain_name)
          expect(@ipw.valid).to eq(false)
          expect(@ipw.legacy).to eq(false)
          expect(@ipw.a_record).to be_a(
            SendGrid4r::REST::Whitelabel::Ips::ARecord
          )
          expect(@ipw.a_record.valid).to eq(false)
          expect(@ipw.a_record.type).to eq('a')
          expect(@ipw.a_record.host).to be_a(String)
          expect(@ipw.a_record.data).to eq(@ip)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_wl_ip' do
        begin
          ip = @client.get_wl_ip(id: @ipw.id)
          expect(ip).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
          expect(ip.ip).to eq(@ip)
          expect(ip.users).to be_a(Array)
          expect(ip.subdomain).to eq(@subdomain_name)
          expect(ip.domain).to eq(@domain_name)
          expect(ip.valid).to eq(false)
          expect(ip.legacy).to eq(false)
          expect(ip.a_record).to be_a(
            SendGrid4r::REST::Whitelabel::Ips::ARecord
          )
          expect(ip.a_record.valid).to eq(false)
          expect(ip.a_record.type).to eq('a')
          expect(ip.a_record.host).to be_a(String)
          expect(ip.a_record.data).to eq(@ip)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_wl_ip' do
        begin
          @client.delete_wl_ip(id: @ipw.id)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#validate_wl_ip' do
        begin
          result = @client.validate_wl_ip(id: @ipw.id)
          expect(result).to be_a(
            SendGrid4r::REST::Whitelabel::Ips::Result
          )
          expect(result.valid).to be(false)
          expect(result.validation_results.a_record.valid).to be(false)
          expect(result.validation_results.a_record.reason).to be_a(String)
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

    let(:ips) do
      JSON.parse('[]')
    end

    let(:ip) do
      JSON.parse(
        '{'\
          '"id": 123,'\
          '"ip": "192.168.1.2",'\
          '"rdns": "o1.email.example.com",'\
          '"users": ['\
          '],'\
          '"subdomain": "email",'\
          '"domain": "example.com",'\
          '"valid": true,'\
          '"legacy": false,'\
          '"a_record": {'\
            '"valid": true,'\
            '"type": "a",'\
            '"host": "o1.email.example.com",'\
            '"data": "192.168.1.2"'\
          '}'\
        '}'
      )
    end

    let(:result) do
      JSON.parse(
        '{'\
          '"id": 1,'\
          '"valid": true,'\
          '"validation_results": {'\
            '"a_record": {'\
              '"valid": true,'\
              '"reason": null'\
            '}'\
          '}'\
        '}'
      )
    end

    it '#get_wl_ips' do
      allow(client).to receive(:execute).and_return(ips)
      actual = client.get_wl_ips
      expect(actual).to be_a(Array)
    end

    it '#post_wl_ip' do
      allow(client).to receive(:execute).and_return(ip)
      actual = client.post_wl_ip(ip: '', subdomain: '', domain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
    end

    it '#get_wl_ip' do
      allow(client).to receive(:execute).and_return(ip)
      actual = client.get_wl_ip(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
    end

    it '#delete_wl_ip' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_wl_ip(id: '')
      expect(actual).to eq('')
    end

    it '#validate_wl_ip' do
      allow(client).to receive(:execute).and_return(result)
      actual = client.validate_wl_ip(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Ips::Result)
    end

    it 'creates ip instance' do
      actual = SendGrid4r::REST::Whitelabel::Ips.create_ip(ip)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Ips::Ip)
      expect(actual.id).to eq(123)
      expect(actual.ip).to eq('192.168.1.2')
      expect(actual.rdns).to eq('o1.email.example.com')
      expect(actual.users).to eq([])
      expect(actual.subdomain).to eq('email')
      expect(actual.domain).to eq('example.com')
      expect(actual.valid).to eq(true)
      expect(actual.legacy).to eq(false)
      expect(actual.a_record).to be_a(
        SendGrid4r::REST::Whitelabel::Ips::ARecord
      )
      expect(actual.a_record.valid).to eq(true)
      expect(actual.a_record.type).to eq('a')
      expect(actual.a_record.host).to eq('o1.email.example.com')
      expect(actual.a_record.data).to eq('192.168.1.2')
    end

    it 'creates result instance' do
      actual = SendGrid4r::REST::Whitelabel::Ips.create_result(result)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Ips::Result)
      expect(actual.id).to eq(1)
      expect(actual.valid).to eq(true)
      expect(actual.validation_results).to be_a(
        SendGrid4r::REST::Whitelabel::Ips::ValidationResults
      )
      expect(actual.validation_results.a_record).to be_a(
        SendGrid4r::REST::Whitelabel::Ips::ValidationResult
      )
      expect(actual.validation_results.a_record.valid).to be(true)
      expect(actual.validation_results.a_record.reason).to be(nil)
    end
  end
end
