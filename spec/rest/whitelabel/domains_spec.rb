# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Whitelabel::Domains do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @subdomain_name = ENV['SUBDOMAIN_DOMAIN']
        @domain_name = ENV['DOMAIN']
        @username = ENV['USERNAME']
        @ip = ENV['IP']
        @subuser1 = ENV['SUBUSER1']
        @subuser2 = ENV['SUBUSER2']

        # celan up test env(lists)
        domains = @client.get_wl_domains
        domains.each do |domain|
          if domain.subdomain == "#{@subdomain_name}1" &&
             domain.domain == @domain_name
            @client.delete_wl_domain(id: domain.id)
          end
          if domain.subdomain == "#{@subdomain_name}2" &&
             domain.domain == @domain_name
            @client.delete_wl_domain(id: domain.id)
          end
        end

        # post domain
        @domain1 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '1',
          username: @username, ips: nil,
          automatic_security: true, custom_spf: false, default: false
        )
        @domain2 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '2',
          username: @username, ips: nil,
          automatic_security: false, custom_spf: true, default: false
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_domains' do
        begin
          domains = @client.get_wl_domains
          expect(domains).to be_a(Array)
          domains.each do |domain|
            expect(domain).to be_a(
              SendGrid4r::REST::Whitelabel::Domains::Domain
            )
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#post_domain' do
        begin
          expect(@domain1).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Domain
          )
          expect(@domain1.domain).to eq(@domain_name)
          expect(@domain1.subdomain).to eq(@subdomain_name + '1')
          expect(@domain1.username).to eq(@username)
          expect(@domain1.user_id).to be_a(Numeric)
          expect(@domain1.ips).to eq([])
          expect(@domain1.automatic_security).to eq(true)
          expect(@domain1.custom_spf).to eq(false)
          expect(@domain1.default).to eq(false)
          expect(@domain1.legacy).to eq(false)
          expect(@domain1.valid).to eq(false)
          expect(@domain1.dns.mail_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain1.dns.spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain1.dns.dkim1).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain1.dns.dkim2).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain2).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Domain
          )
          expect(@domain2.domain).to eq(@domain_name)
          expect(@domain2.subdomain).to eq(@subdomain_name + '2')
          expect(@domain2.username).to eq(@username)
          expect(@domain2.user_id).to be_a(Numeric)
          expect(@domain2.ips).to eq([])
          expect(@domain2.automatic_security).to eq(false)
          expect(@domain2.custom_spf).to eq(true)
          expect(@domain2.default).to eq(false)
          expect(@domain2.legacy).to eq(false)
          expect(@domain2.valid).to eq(false)
          expect(@domain2.dns.mail_server).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain2.dns.subdomain_spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain2.dns.domain_spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(@domain2.dns.dkim).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_domain' do
        begin
          domain1 = @client.get_wl_domain(id: @domain1.id)
          expect(domain1).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
          expect(domain1.domain).to eq(@domain_name)
          expect(domain1.subdomain).to eq(@subdomain_name + '1')
          expect(domain1.username).to eq(@username)
          expect(domain1.user_id).to be_a(Numeric)
          expect(domain1.ips).to eq([])
          expect(domain1.automatic_security).to eq(true)
          expect(domain1.custom_spf).to eq(false)
          expect(domain1.default).to eq(false)
          expect(domain1.legacy).to eq(false)
          expect(domain1.valid).to eq(false)
          expect(domain1.dns.mail_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain1.dns.spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain1.dns.dkim1).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain1.dns.dkim2).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          domain2 = @client.get_wl_domain(id: @domain2.id)
          expect(domain2).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
          expect(domain2.domain).to eq(@domain_name)
          expect(domain2.subdomain).to eq(@subdomain_name + '2')
          expect(domain2.username).to eq(@username)
          expect(domain2.user_id).to be_a(Numeric)
          expect(domain2.ips).to eq([])
          expect(domain2.automatic_security).to eq(false)
          expect(domain2.custom_spf).to eq(true)
          expect(domain2.default).to eq(false)
          expect(domain2.legacy).to eq(false)
          expect(domain2.valid).to eq(false)
          expect(domain2.dns.mail_server).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain2.dns.subdomain_spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain2.dns.domain_spf).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
          expect(domain2.dns.dkim).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Record
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_domain' do
        begin
          domain1 = @client.patch_wl_domain(
            id: @domain1.id, custom_spf: true, default: nil
          )
          expect(domain1).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
          expect(domain1.domain).to eq(@domain_name)
          expect(domain1.subdomain).to eq(@subdomain_name + '1')
          expect(domain1.username).to eq(@username)
          expect(domain1.user_id).to be_a(Numeric)
          expect(domain1.ips).to eq([])
          expect(domain1.automatic_security).to eq(true)
          expect(domain1.custom_spf).to eq(true)
          expect(domain1.default).to eq(false)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_domain' do
        begin
          @client.delete_wl_domain(id: @domain1.id)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_default_domain' do
        begin
          domain2 = @client.get_default_wl_domain
          expect(domain2).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#add_ip_to_domain' do
        begin
          domain2 = @client.add_ip_to_wl_domain(id: @domain2.id, ip: @ip)
          expect(domain2.ips).to eq([@ip])
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#remove_ip_from_domain' do
        begin
          @client.add_ip_to_wl_domain(id: @domain2.id, ip: @ip)
          domain2 = @client.remove_ip_from_wl_domain(
            id: @domain2.id, ip: @ip
          )
          expect(domain2.ips).to eq(nil)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#validate_domain' do
        begin
          result1 = @client.validate_wl_domain(id: @domain1.id)
          expect(result1).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Result
          )
          expect(result1.valid).to be(false)
          expect(result1.validation_results.mail_cname.valid).to be(
            false
          )
          expect(result1.validation_results.dkim1.valid).to be(
            false
          )
          expect(result1.validation_results.dkim2.valid).to be(
            false
          )
          expect(result1.validation_results.spf.valid).to be(
            false
          )
          result2 = @client.validate_wl_domain(id: @domain2.id)
          expect(result2).to be_a(
            SendGrid4r::REST::Whitelabel::Domains::Result
          )
          expect(result2.valid).to be(false)
          expect(result2.validation_results.mail_server.valid).to be(
            false
          )
          expect(result2.validation_results.subdomain_spf.valid).to be(
            false
          )
          expect(result2.validation_results.domain_spf.valid).to be(
            false
          )
          expect(result2.validation_results.dkim.valid).to be(
            false
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_associated_wl_domain' do
        begin
          domain1 = @client.get_associated_wl_domain(username: @subuser1)
          expect(domain1).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#associate_wl_domain' do
        begin
          @client.associate_wl_domain(id: @domain2.id, username: @subuser1)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#disassociate_wl_domain' do
        begin
          @client.associate_wl_domain(id: @domain2.id, username: @subuser1)
          @client.disassociate_wl_domain(username: @subuser1)
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

    let(:domains) do
      JSON.parse('[]')
    end

    let(:domain) do
      JSON.parse(
        '{'\
          '"id": 1,'\
          '"domain": "example.com",'\
          '"subdomain": "mail",'\
          '"username": "john@example.com",'\
          '"user_id": 7,'\
          '"ips": ['\
            '"192.168.1.1",'\
            '"192.168.1.2"'\
          '],'\
          '"custom_spf": true,'\
          '"default": true,'\
          '"legacy": false,'\
          '"automatic_security": true,'\
          '"valid": true,'\
          '"dns": {'\
            '"mail_cname": {'\
              '"host": "mail.example.com",'\
              '"type": "cname",'\
              '"data": "u7.wl.sendgrid.net",'\
              '"valid": true'\
            '},'\
            '"spf": {'\
              '"host": "example.com",'\
              '"type": "txt",'\
              '"data": "v=spf1 include:u7.wl.sendgrid.net -all",'\
              '"valid": true'\
            '},'\
            '"dkim1": {'\
              '"host": "s1._domainkey.example.com",'\
              '"type": "cname",'\
              '"data": "s1._domainkey.u7.wl.sendgrid.net",'\
              '"valid": true'\
            '},'\
            '"dkim2": {'\
              '"host": "s2._domainkey.example.com",'\
              '"type": "cname",'\
              '"data": "s2._domainkey.u7.wl.sendgrid.net",'\
              '"valid": true'\
            '}'\
          '}'\
        '}'
      )
    end

    let(:domain2) do
      JSON.parse(
        '{'\
          '"id": 2,'\
          '"user_id": 2,'\
          '"subdomain": "mail2",'\
          '"domain": "example.com",'\
          '"username": "john@example.com",'\
          '"ips": [],'\
          '"custom_spf": true,'\
          '"default": false,'\
          '"legacy": false,'\
          '"automatic_security": false,'\
          '"valid": false,'\
          '"dns": {'\
            '"mail_server": {'\
              '"valid": false,'\
              '"type": "mx",'\
              '"host": "mail2.example.com",'\
              '"data": "mx.sendgrid.net."'\
            '},'\
            '"subdomain_spf": {'\
              '"valid": false,'\
              '"type": "txt",'\
              '"host": "mail2.example.com",'\
              '"data": "v=spf1 include:sendgrid.net ~all"'\
            '},'\
            '"domain_spf": {'\
              '"valid": false,'\
              '"type": "txt",'\
              '"host": "example.com",'\
              '"data": "v=spf1 include:mail2.example.com -all"'\
            '},'\
            '"dkim": {'\
              '"valid": false,'\
              '"type": "txt",'\
              '"host": "m1._domainkey.example.com",'\
              '"data": "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQ"'\
            '}'\
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
            '"mail_cname": {'\
              '"valid": false,'\
              '"reason": "Expected your MX record to be \"mx.sendgrid.net\" '\
              'but found \"example.com\"."'\
            '},'\
            '"dkim1": {'\
              '"valid": true,'\
              '"reason": null'\
            '},'\
            '"dkim2": {'\
              '"valid": true,'\
              '"reason": null'\
            '},'\
            '"spf": {'\
              '"valid": true,'\
              '"reason": null'\
            '}'\
          '}'\
        '}'
      )
    end

    it '#get_domains' do
      allow(client).to receive(:execute).and_return(domains)
      actual = client.get_wl_domains
      expect(actual).to be_a(Array)
    end

    it '#post_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.post_wl_domain(domain: '', subdomain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#get_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.get_wl_domain(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#patch_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.patch_wl_domain(id: '', domain: '', subdomain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#delete_domain' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_wl_domain(id: '')
      expect(actual).to eq('')
    end

    it '#get_default_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.get_default_wl_domain(domain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#add_ip_to_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.add_ip_to_wl_domain(id: '', ip: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#remove_ip_from_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.remove_ip_from_wl_domain(id: '', ip: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#validate_domain' do
      allow(client).to receive(:execute).and_return(result)
      actual = client.validate_wl_domain(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Result)
    end

    it '#get_associated_wl_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.get_associated_wl_domain(username: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it '#disassociate_wl_domain' do
      allow(client).to receive(:execute).and_return('')
      actual = client.disassociate_wl_domain(username: '')
      expect(actual).to eq('')
    end

    it '#associate_wl_domain' do
      allow(client).to receive(:execute).and_return(domain)
      actual = client.associate_wl_domain(id: '', username: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
    end

    it 'creates domain instance' do
      actual = SendGrid4r::REST::Whitelabel::Domains.create_domain(domain)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
      expect(actual.id).to eq(1)
      expect(actual.domain).to eq('example.com')
      expect(actual.subdomain).to eq('mail')
      expect(actual.username).to eq('john@example.com')
      expect(actual.user_id).to eq(7)
      expect(actual.ips).to be_a(Array)
      expect(actual.ips[0]).to eq('192.168.1.1')
      expect(actual.ips[1]).to eq('192.168.1.2')
      expect(actual.custom_spf).to eq(true)
      expect(actual.default).to eq(true)
      expect(actual.legacy).to eq(false)
      expect(actual.automatic_security).to eq(true)
      expect(actual.valid).to eq(true)
      expect(actual.dns).to be_a(SendGrid4r::REST::Whitelabel::Domains::Dns)
      expect(actual.dns.mail_cname).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.mail_cname.host).to eq('mail.example.com')
      expect(actual.dns.mail_cname.type).to eq('cname')
      expect(actual.dns.mail_cname.data).to eq('u7.wl.sendgrid.net')
      expect(actual.dns.mail_cname.valid).to eq(true)
      expect(actual.dns.spf).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.spf.host).to eq('example.com')
      expect(actual.dns.spf.type).to eq('txt')
      expect(actual.dns.spf.data).to eq(
        'v=spf1 include:u7.wl.sendgrid.net -all'
      )
      expect(actual.dns.spf.valid).to eq(true)
      expect(actual.dns.dkim1).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.dkim1.host).to eq('s1._domainkey.example.com')
      expect(actual.dns.dkim1.type).to eq('cname')
      expect(actual.dns.dkim1.data).to eq('s1._domainkey.u7.wl.sendgrid.net')
      expect(actual.dns.dkim1.valid).to eq(true)
      expect(actual.dns.dkim2).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.dkim2.host).to eq('s2._domainkey.example.com')
      expect(actual.dns.dkim2.type).to eq('cname')
      expect(actual.dns.dkim2.data).to eq('s2._domainkey.u7.wl.sendgrid.net')
      expect(actual.dns.dkim2.valid).to eq(true)
    end

    it 'creates domain2 instance' do
      actual = SendGrid4r::REST::Whitelabel::Domains.create_domain(domain2)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Domain)
      expect(actual.id).to eq(2)
      expect(actual.domain).to eq('example.com')
      expect(actual.subdomain).to eq('mail2')
      expect(actual.username).to eq('john@example.com')
      expect(actual.user_id).to eq(2)
      expect(actual.ips).to be_a(Array)
      expect(actual.custom_spf).to eq(true)
      expect(actual.default).to eq(false)
      expect(actual.legacy).to eq(false)
      expect(actual.automatic_security).to eq(false)
      expect(actual.valid).to eq(false)
      expect(actual.dns).to be_a(SendGrid4r::REST::Whitelabel::Domains::Dns)
      expect(actual.dns.mail_server).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.mail_server.host).to eq('mail2.example.com')
      expect(actual.dns.mail_server.type).to eq('mx')
      expect(actual.dns.mail_server.data).to eq('mx.sendgrid.net.')
      expect(actual.dns.mail_server.valid).to eq(false)
      expect(actual.dns.subdomain_spf).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.subdomain_spf.host).to eq('mail2.example.com')
      expect(actual.dns.subdomain_spf.type).to eq('txt')
      expect(actual.dns.subdomain_spf.data).to eq(
        'v=spf1 include:sendgrid.net ~all'
      )
      expect(actual.dns.subdomain_spf.valid).to eq(false)
      expect(actual.dns.domain_spf).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.domain_spf.host).to eq('example.com')
      expect(actual.dns.domain_spf.type).to eq('txt')
      expect(actual.dns.domain_spf.data).to eq(
        'v=spf1 include:mail2.example.com -all'
      )
      expect(actual.dns.domain_spf.valid).to eq(false)
      expect(actual.dns.dkim).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::Record
      )
      expect(actual.dns.dkim.host).to eq('m1._domainkey.example.com')
      expect(actual.dns.dkim.type).to eq('txt')
      expect(actual.dns.dkim.data).to eq(
        'k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQ'
      )
      expect(actual.dns.dkim.valid).to eq(false)
    end

    it 'creates result instance' do
      actual = SendGrid4r::REST::Whitelabel::Domains.create_result(result)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Domains::Result)
      expect(actual.id).to eq(1)
      expect(actual.valid).to eq(true)
      expect(actual.validation_results).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::ValidationResults
      )
      expect(actual.validation_results.dkim1).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::ValidationResult
      )
      expect(actual.validation_results.dkim1.valid).to be(true)
      expect(actual.validation_results.dkim1.reason).to be(nil)
      expect(actual.validation_results.dkim2).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::ValidationResult
      )
      expect(actual.validation_results.dkim2.valid).to be(true)
      expect(actual.validation_results.dkim2.reason).to be(nil)
      expect(actual.validation_results.spf).to be_a(
        SendGrid4r::REST::Whitelabel::Domains::ValidationResult
      )
      expect(actual.validation_results.spf.valid).to be(true)
      expect(actual.validation_results.spf.reason).to be(nil)
    end
  end
end
