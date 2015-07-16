# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Whitelabel::Links do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @subdomain_name = ENV['SUBDOMAIN_LINK']
        @domain_name = ENV['DOMAIN']
        @username = ENV['USERNAME']
        @subuser1 = ENV['SUBUSER1']

        # celan up test env(lists)
        links = @client.get_wl_links
        links.each do |link|
          @client.delete_wl_link(
            id: link.id
          ) if "#{link.subdomain}.#{link.domain}" == "#{@subdomain_name}1.#{@domain_name}"
        end

        # post link
        @link1 = @client.post_wl_link(
          subdomain: @subdomain_name + '1', domain: @domain_name, default: false
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_wl_links' do
        begin
          links = @client.get_wl_links
          expect(links).to be_a(Array)
          links.each do |link|
            expect(link).to be_a(
              SendGrid4r::REST::Whitelabel::Links::Link
            )
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#post_wl_link' do
        begin
          expect(@link1).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
          expect(@link1.domain).to eq(@domain_name)
          expect(@link1.subdomain).to eq(@subdomain_name + '1')
          expect(@link1.username).to eq(@username)
          expect(@link1.user_id).to be_a(Numeric)
          expect(@link1.default).to eq(false)
          expect(@link1.valid).to eq(false)
          expect(@link1.legacy).to eq(false)
          expect(@link1.dns.domain_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
          expect(@link1.dns.owner_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_wl_link' do
        begin
          link1 = @client.get_wl_link(id: @link1.id)
          expect(link1).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
          expect(link1.domain).to eq(@domain_name)
          expect(link1.subdomain).to eq(@subdomain_name + '1')
          expect(link1.username).to eq(@username)
          expect(link1.user_id).to be_a(Numeric)
          expect(link1.default).to eq(false)
          expect(link1.valid).to eq(false)
          expect(link1.legacy).to eq(false)
          expect(link1.dns.domain_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
          expect(link1.dns.owner_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#patch_wl_link' do
        begin
          link1 = @client.patch_wl_link(id: @link1.id, default: false)
          expect(link1).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
          expect(link1.domain).to eq(@domain_name)
          expect(link1.subdomain).to eq(@subdomain_name + '1')
          expect(link1.username).to eq(@username)
          expect(link1.user_id).to be_a(Numeric)
          expect(link1.default).to eq(false)
          expect(link1.valid).to eq(false)
          expect(link1.legacy).to eq(false)
          expect(link1.dns.domain_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
          expect(link1.dns.owner_cname).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Record
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_wl_link' do
        begin
          @client.delete_wl_link(id: @link1.id)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_default_wl_link' do
        begin
          link = @client.get_default_wl_link
          expect(link).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#validate_wl_link' do
        begin
          result1 = @client.validate_wl_link(id: @link1.id)
          expect(result1).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Result
          )
          expect(result1.valid).to be(false)
          expect(result1.validation_results.domain_cname.valid).to be(
            false
          )
          expect(result1.validation_results.owner_cname.valid).to be(
            false
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_associated_wl_link' do
        begin
          link1 = @client.get_associated_wl_link(username: @subuser1)
          expect(link1).to be_a(
            SendGrid4r::REST::Whitelabel::Links::Link
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#associate_wl_link' do
        begin
          @client.associate_wl_link(
            id: @link1.id, username: @subuser1
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#disassociate_wl_link' do
        begin
          @client.associate_wl_link(
            id: @link1.id, username: @subuser1
          )
          @client.disassociate_wl_link(username: @subuser1)
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

    let(:links) do
      JSON.parse('[]')
    end

    let(:link) do
      JSON.parse(
        '{'\
          '"id": 1,'\
          '"domain": "example.com",'\
          '"subdomain": "mail",'\
          '"username": "john@example.com",'\
          '"user_id": 7,'\
          '"default": false,'\
          '"valid": true,'\
          '"legacy": false,'\
          '"dns": {'\
            '"domain_cname": {'\
              '"valid": true,'\
              '"type": "cname",'\
              '"host": "mail.example.com",'\
              '"data": "sendgrid.net"'\
            '},'\
            '"owner_cname": {'\
              '"valid": true,'\
              '"type": "cname",'\
              '"host": "7.example.com",'\
              '"data": "sendgrid.net"'\
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
            '"domain_cname": {'\
              '"valid": false,'\
              '"reason": "Expected CNAME to match \"sendgrid.net.\" but found \"example.com.\"."'\
            '},'\
            '"owner_cname": {'\
              '"valid": true,'\
              '"reason": null'\
            '}'\
          '}'\
        '}'
      )
    end

    it '#get_wl_links' do
      allow(client).to receive(:execute).and_return(links)
      actual = client.get_wl_links
      expect(actual).to be_a(Array)
    end

    it '#post_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.post_wl_link(domain: '', subdomain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it '#get_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.get_wl_link(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it '#patch_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.patch_wl_link(id: '', default: true)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it '#delete_wl_link' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_wl_link(id: '')
      expect(actual).to eq('')
    end

    it '#get_default_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.get_default_wl_link(domain: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it '#validate_link' do
      allow(client).to receive(:execute).and_return(result)
      actual = client.validate_wl_link(id: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Result)
    end

    it '#get_associated_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.get_associated_wl_link(username: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it '#disassociate_wl_link' do
      allow(client).to receive(:execute).and_return('')
      actual = client.disassociate_wl_link(username: '')
      expect(actual).to eq('')
    end

    it '#associate_wl_link' do
      allow(client).to receive(:execute).and_return(link)
      actual = client.associate_wl_link(id: '', username: '')
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
    end

    it 'creates link instance' do
      actual = SendGrid4r::REST::Whitelabel::Links.create_link(link)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Link)
      expect(actual.id).to eq(1)
      expect(actual.domain).to eq('example.com')
      expect(actual.subdomain).to eq('mail')
      expect(actual.username).to eq('john@example.com')
      expect(actual.user_id).to eq(7)
      expect(actual.default).to eq(false)
      expect(actual.valid).to eq(true)
      expect(actual.legacy).to eq(false)
      expect(actual.dns).to be_a(SendGrid4r::REST::Whitelabel::Links::Dns)
      expect(actual.dns.domain_cname).to be_a(
        SendGrid4r::REST::Whitelabel::Links::Record
      )
      expect(actual.dns.domain_cname.host).to eq('mail.example.com')
      expect(actual.dns.domain_cname.type).to eq('cname')
      expect(actual.dns.domain_cname.data).to eq('sendgrid.net')
      expect(actual.dns.domain_cname.valid).to eq(true)
      expect(actual.dns.owner_cname).to be_a(
        SendGrid4r::REST::Whitelabel::Links::Record
      )
      expect(actual.dns.owner_cname.host).to eq('7.example.com')
      expect(actual.dns.owner_cname.type).to eq('cname')
      expect(actual.dns.owner_cname.data).to eq('sendgrid.net')
      expect(actual.dns.owner_cname.valid).to eq(true)
    end

    it 'creates result instance' do
      actual = SendGrid4r::REST::Whitelabel::Links.create_result(result)
      expect(actual).to be_a(SendGrid4r::REST::Whitelabel::Links::Result)
      expect(actual.id).to eq(1)
      expect(actual.valid).to eq(true)
      expect(actual.validation_results).to be_a(
        SendGrid4r::REST::Whitelabel::Links::ValidationResults
      )
      expect(actual.validation_results.domain_cname).to be_a(
        SendGrid4r::REST::Whitelabel::Links::ValidationResult
      )
      expect(actual.validation_results.domain_cname.valid).to be(false)
      expect(actual.validation_results.domain_cname.reason).to be_a(String)
      expect(actual.validation_results.owner_cname).to be_a(
        SendGrid4r::REST::Whitelabel::Links::ValidationResult
      )
      expect(actual.validation_results.owner_cname.valid).to be(true)
      expect(actual.validation_results.owner_cname.reason).to be(nil)
    end
  end
end
