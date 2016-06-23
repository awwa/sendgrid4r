# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Whitelabel
  describe Domains do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @subdomain_name = ENV['SUBDOMAIN_DOMAIN']
        @domain_name = ENV['DOMAIN']
        @username = ENV['USERNAME']
        @subuser = ENV['SUBUSER']
        @email1 = ENV['MAIL']
        @password1 = ENV['PASS']
        @ip = ENV['IP']
        # celan up test env
        @id1 = nil
        @id2 = nil
        @id3 = nil
        @id4 = nil
        domains = @client.get_wl_domains
        domains.each do |domain|
          if domain.subdomain == "#{@subdomain_name}1" &&
             domain.domain == @domain_name
            @id1 = domain.id
          end
          if domain.subdomain == "#{@subdomain_name}2" &&
             domain.domain == @domain_name
            @id2 = domain.id
          end
          if domain.subdomain == "#{@subdomain_name}3" &&
             domain.domain == @domain_name
            @id3 = domain.id
          end
          if domain.subdomain == "#{@subdomain_name}4" &&
             domain.domain == @domain_name
            @id4 = domain.id
          end
        end
        # post domain
        @client.delete_wl_domain(id: @id1) unless @id1.nil?
        @client.delete_wl_domain(id: @id2) unless @id2.nil?
        @client.delete_wl_domain(id: @id3) unless @id3.nil?
        @client.delete_wl_domain(id: @id4) unless @id4.nil?
        @domain1 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '1'
        )
        @domain2 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '2',
          username: @subuser, ips: nil,
          automatic_security: false, custom_spf: false, default: false
        )
        @domain3 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '3',
          username: @subuser, ips: nil,
          automatic_security: true, custom_spf: false, default: false
        )
        @domain4 = @client.post_wl_domain(
          domain: @domain_name, subdomain: @subdomain_name + '4',
          username: @subuser, ips: [@ip],
          automatic_security: false, custom_spf: true, default: false
        )
      end

      context 'without block call' do
        it '#get_wl_domains' do
          domains = @client.get_wl_domains
          expect(domains).to be_a(Array)
          domains.each do |domain|
            expect(domain).to be_a(Domains::Domain)
          end
        end

        it '#post_wl_domain' do
          expect(@domain1).to be_a(Domains::Domain)
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
          expect(@domain1.dns.mail_cname).to be_a(Domains::Record)
          expect(@domain1.dns.dkim1).to be_a(Domains::Record)
          expect(@domain1.dns.dkim2).to be_a(Domains::Record)
          expect(@domain2).to be_a(Domains::Domain)
          expect(@domain2.domain).to eq(@domain_name)
          expect(@domain2.subdomain).to eq(@subdomain_name + '2')
          expect(@domain2.username).to eq(@subuser)
          expect(@domain2.user_id).to be_a(Numeric)
          expect(@domain2.ips).to eq([])
          expect(@domain2.automatic_security).to eq(false)
          expect(@domain2.custom_spf).to eq(false)
          expect(@domain2.default).to eq(false)
          expect(@domain2.legacy).to eq(false)
          expect(@domain2.valid).to eq(false)
          expect(@domain2.dns.mail_server).to be_a(Domains::Record)
          expect(@domain2.dns.subdomain_spf).to be_a(Domains::Record)
          expect(@domain2.dns.dkim).to be_a(Domains::Record)
        end

        it '#get_wl_domain' do
          domain1 = @client.get_wl_domain(id: @domain1.id)
          expect(domain1).to be_a(Domains::Domain)
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
          # mail_cname
          expect(domain1.dns.mail_cname).to be_a(Domains::Record)
          expect(domain1.dns.mail_cname.valid).to eq(false)
          expect(domain1.dns.mail_cname.type).to eq('cname')
          expect(domain1.dns.mail_cname.host).to eq(
            "#{@subdomain_name}1.#{@domain_name}"
          )
          expect(domain1.dns.mail_cname.data).to be_a(String)
          # dkim1
          expect(domain1.dns.dkim1).to be_a(
            Domains::Record
          )
          expect(domain1.dns.dkim1.valid).to eq(false)
          expect(domain1.dns.dkim1.type).to eq('cname')
          expect(domain1.dns.dkim1.host).to eq("s1._domainkey.#{@domain_name}")
          expect(domain1.dns.dkim1.data).to be_a(String)
          # dkim2
          expect(domain1.dns.dkim2).to be_a(Domains::Record)
          expect(domain1.dns.dkim2.valid).to eq(false)
          expect(domain1.dns.dkim2.type).to eq('cname')
          expect(domain1.dns.dkim2.host).to eq("s2._domainkey.#{@domain_name}")
          expect(domain1.dns.dkim2.data).to be_a(String)
          domain2 = @client.get_wl_domain(id: @domain2.id)
          expect(domain2).to be_a(Domains::Domain)
          expect(domain2.domain).to eq(@domain_name)
          expect(domain2.subdomain).to eq(@subdomain_name + '2')
          expect(domain2.username).to eq(@subuser)
          expect(domain2.user_id).to be_a(Numeric)
          expect(domain2.ips).to eq([])
          expect(domain2.automatic_security).to eq(false)
          expect(domain2.custom_spf).to eq(false)
          expect(domain2.default).to eq(false)
          expect(domain2.legacy).to eq(false)
          expect(domain2.valid).to eq(false)
          # mail_server
          expect(domain2.dns.mail_server).to be_a(Domains::Record)
          expect(domain2.dns.mail_server.valid).to eq(false)
          expect(domain2.dns.mail_server.type).to eq('mx')
          expect(domain2.dns.mail_server.host).to eq(
            "#{@subdomain_name}2.#{@domain_name}"
          )
          expect(domain2.dns.mail_server.data).to eq('mx.sendgrid.net.')
          # subdomain_spf
          expect(domain2.dns.subdomain_spf).to be_a(Domains::Record)
          expect(domain2.dns.subdomain_spf.valid).to eq(false)
          expect(domain2.dns.subdomain_spf.type).to eq('txt')
          expect(domain2.dns.subdomain_spf.host).to eq(
            "#{@subdomain_name}2.#{@domain_name}"
          )
          expect(domain2.dns.subdomain_spf.data).to eq(
            'v=spf1 include:sendgrid.net ~all'
          )
          # dkim
          expect(domain2.dns.dkim).to be_a(Domains::Record)
          expect(domain2.dns.dkim.valid).to eq(false)
          expect(domain2.dns.dkim.type).to eq('txt')
          expect(domain2.dns.dkim.host).to eq("m1._domainkey.#{@domain_name}")
          expect(domain2.dns.dkim.data).to start_with('k=rsa; t=s; p=')
          domain4 = @client.get_wl_domain(id: @domain4.id)
          expect(domain4).to be_a(Domains::Domain)
          expect(domain4.domain).to eq(@domain_name)
          expect(domain4.subdomain).to eq(@subdomain_name + '4')
          expect(domain4.username).to eq(@subuser)
          expect(domain4.user_id).to be_a(Numeric)
          expect(domain4.ips).to eq([@ip])
          expect(domain4.automatic_security).to eq(false)
          expect(domain4.custom_spf).to eq(true)
          expect(domain4.default).to eq(false)
          expect(domain4.legacy).to eq(false)
          expect(domain4.valid).to eq(false)
          # mail_server
          expect(domain4.dns.mail_server).to be_a(Domains::Record)
          expect(domain4.dns.mail_server.valid).to eq(false)
          expect(domain4.dns.mail_server.type).to eq('mx')
          expect(domain4.dns.mail_server.host).to eq(
            "#{@subdomain_name}4.#{@domain_name}"
          )
          expect(domain4.dns.mail_server.data).to eq('mx.sendgrid.net.')
          # subdomain_spf
          expect(domain4.dns.subdomain_spf).to be_a(Domains::Record)
          expect(domain4.dns.subdomain_spf.valid).to eq(false)
          expect(domain4.dns.subdomain_spf.type).to eq('txt')
          expect(domain4.dns.subdomain_spf.host).to eq(
            "#{@subdomain_name}4.#{@domain_name}"
          )
          expect(domain4.dns.subdomain_spf.data).to eq("v=spf1 ip4:#{@ip} -all")
          # dkim
          expect(domain4.dns.dkim).to be_a(Domains::Record)
          expect(domain4.dns.dkim.valid).to eq(false)
          expect(domain4.dns.dkim.type).to eq('txt')
          expect(domain4.dns.dkim.host).to eq("m1._domainkey.#{@domain_name}")
          expect(domain4.dns.dkim.data).to start_with('k=rsa; t=s; p=')
        end

        it '#patch_wl_domain' do
          domain1 = @client.patch_wl_domain(
            id: @domain1.id, custom_spf: true, default: nil
          )
          expect(domain1).to be_a(Domains::Domain)
          expect(domain1.domain).to eq(@domain_name)
          expect(domain1.subdomain).to eq(@subdomain_name + '1')
          expect(domain1.username).to eq(@username)
          expect(domain1.user_id).to be_a(Numeric)
          expect(domain1.ips).to eq([])
          expect(domain1.automatic_security).to eq(true)
          expect(domain1.custom_spf).to eq(true)
          expect(domain1.default).to eq(false)
        end

        it '#delete_wl_domain' do
          @client.delete_wl_domain(id: @domain1.id)
        end

        it '#get_default_wl_domain' do
          domain2 = @client.get_default_wl_domain
          expect(domain2).to be_a(Domains::Domain)
        end

        it '#add_ip_to_wl_domain' do
          domain2 = @client.add_ip_to_wl_domain(id: @domain2.id, ip: @ip)
          expect(domain2.ips).to eq([@ip])
        end

        it '#remove_ip_from_wl_domain' do
          @client.add_ip_to_wl_domain(id: @domain2.id, ip: @ip)
          @client.remove_ip_from_wl_domain(id: @domain2.id, ip: @ip)
        end

        it '#validate_wl_domain' do
          result1 = @client.validate_wl_domain(id: @domain1.id)
          expect(result1).to be_a(Domains::Result)
          expect(result1.valid).to be(false)
          expect(result1.validation_results.mail_cname.valid).to be(false)
          expect(result1.validation_results.mail_cname.reason).to be_a(String)
          expect(result1.validation_results.dkim1.valid).to be(false)
          expect(result1.validation_results.dkim1.reason).to be_a(String)
          expect(result1.validation_results.dkim2.valid).to be(false)
          expect(result1.validation_results.dkim2.reason).to be_a(String)
          result2 = @client.validate_wl_domain(id: @domain2.id)
          expect(result2).to be_a(Domains::Result)
          expect(result2.valid).to be(false)
          expect(result2.validation_results.mail_server.valid).to be(false)
          expect(result2.validation_results.mail_server.reason).to be_a(String)
          expect(result2.validation_results.subdomain_spf.valid).to be(false)
          expect(result2.validation_results.subdomain_spf.reason).to be_a(
            String
          )
          expect(result2.validation_results.dkim.valid).to be(false)
          expect(result2.validation_results.dkim.reason).to be_a(String)
        end

        it '#get_associated_wl_domain' do
          domain1 = @client.get_associated_wl_domain(username: @subuser)
          expect(domain1).to be_a(Domains::Domain)
        end

        it '#associate_wl_domain' do
          @client.associate_wl_domain(id: @domain2.id, username: @subuser)
        end

        it '#disassociate_wl_domain' do
          @client.associate_wl_domain(id: @domain2.id, username: @subuser)
          @client.disassociate_wl_domain(username: @subuser)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:domains) do
        '[]'
      end

      let(:domain) do
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
      end

      let(:domain2) do
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
            '"dkim": {'\
              '"valid": false,'\
              '"type": "txt",'\
              '"host": "m1._domainkey.example.com",'\
              '"data": "k=rsa; t=s; '\
                'p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQ"'\
            '}'\
          '}'\
        '}'
      end

      let(:result) do
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
            '}'\
          '}'\
        '}'
      end

      it '#get_domains' do
        allow(client).to receive(:execute).and_return(domains)
        actual = client.get_wl_domains
        expect(actual).to be_a(Array)
      end

      it '#post_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.post_wl_domain(domain: '', subdomain: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it '#get_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.get_wl_domain(id: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it '#patch_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.patch_wl_domain(
          id: '', custom_spf: true, default: false
        )
        expect(actual).to be_a(Domains::Domain)
      end

      it '#delete_domain' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_wl_domain(id: '')
        expect(actual).to eq('')
      end

      it '#get_default_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.get_default_wl_domain(domain: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it '#add_ip_to_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.add_ip_to_wl_domain(id: '', ip: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it '#remove_ip_from_domain' do
        allow(client).to receive(:execute).and_return('')
        actual = client.remove_ip_from_wl_domain(id: '', ip: '')
        expect(actual).to eq('')
      end

      it '#validate_domain' do
        allow(client).to receive(:execute).and_return(result)
        actual = client.validate_wl_domain(id: '')
        expect(actual).to be_a(Domains::Result)
      end

      it '#get_associated_wl_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.get_associated_wl_domain(username: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it '#disassociate_wl_domain' do
        allow(client).to receive(:execute).and_return('')
        actual = client.disassociate_wl_domain(username: '')
        expect(actual).to eq('')
      end

      it '#associate_wl_domain' do
        allow(client).to receive(:execute).and_return(domain)
        actual = client.associate_wl_domain(id: '', username: '')
        expect(actual).to be_a(Domains::Domain)
      end

      it 'creates domain instance' do
        actual = Domains.create_domain(JSON.parse(domain))
        expect(actual).to be_a(Domains::Domain)
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
        expect(actual.dns).to be_a(Domains::Dns)
        expect(actual.dns.mail_cname).to be_a(Domains::Record)
        expect(actual.dns.mail_cname.host).to eq('mail.example.com')
        expect(actual.dns.mail_cname.type).to eq('cname')
        expect(actual.dns.mail_cname.data).to eq('u7.wl.sendgrid.net')
        expect(actual.dns.mail_cname.valid).to eq(true)
        expect(actual.dns.dkim1).to be_a(Domains::Record)
        expect(actual.dns.dkim1.host).to eq('s1._domainkey.example.com')
        expect(actual.dns.dkim1.type).to eq('cname')
        expect(actual.dns.dkim1.data).to eq('s1._domainkey.u7.wl.sendgrid.net')
        expect(actual.dns.dkim1.valid).to eq(true)
        expect(actual.dns.dkim2).to be_a(Domains::Record)
        expect(actual.dns.dkim2.host).to eq('s2._domainkey.example.com')
        expect(actual.dns.dkim2.type).to eq('cname')
        expect(actual.dns.dkim2.data).to eq('s2._domainkey.u7.wl.sendgrid.net')
        expect(actual.dns.dkim2.valid).to eq(true)
      end

      it 'creates domain2 instance' do
        actual = Domains.create_domain(JSON.parse(domain2))
        expect(actual).to be_a(Domains::Domain)
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
        expect(actual.dns).to be_a(Domains::Dns)
        expect(actual.dns.mail_server).to be_a(Domains::Record)
        expect(actual.dns.mail_server.host).to eq('mail2.example.com')
        expect(actual.dns.mail_server.type).to eq('mx')
        expect(actual.dns.mail_server.data).to eq('mx.sendgrid.net.')
        expect(actual.dns.mail_server.valid).to eq(false)
        expect(actual.dns.subdomain_spf).to be_a(Domains::Record)
        expect(actual.dns.subdomain_spf.host).to eq('mail2.example.com')
        expect(actual.dns.subdomain_spf.type).to eq('txt')
        expect(actual.dns.subdomain_spf.data).to eq(
          'v=spf1 include:sendgrid.net ~all'
        )
        expect(actual.dns.subdomain_spf.valid).to eq(false)
        expect(actual.dns.dkim).to be_a(Domains::Record)
        expect(actual.dns.dkim.host).to eq('m1._domainkey.example.com')
        expect(actual.dns.dkim.type).to eq('txt')
        expect(actual.dns.dkim.data).to eq(
          'k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQ'
        )
        expect(actual.dns.dkim.valid).to eq(false)
      end

      it 'creates result instance' do
        actual = Domains.create_result(JSON.parse(result))
        expect(actual).to be_a(Domains::Result)
        expect(actual.id).to eq(1)
        expect(actual.valid).to eq(true)
        expect(actual.validation_results).to be_a(Domains::ValidationResults)
        expect(actual.validation_results.dkim1).to be_a(
          Domains::ValidationResult
        )
        expect(actual.validation_results.dkim1.valid).to be(true)
        expect(actual.validation_results.dkim1.reason).to be(nil)
        expect(actual.validation_results.dkim2).to be_a(
          Domains::ValidationResult
        )
        expect(actual.validation_results.dkim2.valid).to be(true)
        expect(actual.validation_results.dkim2.reason).to be(nil)
      end
    end
  end
end
