# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::IpAccessManagement do
  describe 'integration test', :it do
    before do
      begin
        pending('resource not found')
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])

        # clean up test env(whitelisted_ips)
        ips = @client.get_whitelisted_ips
        ips.result.each do |whitelisted_ip|
          @client.delete_whitelisted_ip(rule_id: whitelisted_ip.id)
        end
        @ips = @client.post_whitelisted_ip('0.0.0.0')
        @id1 = @ips.result[0].id
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_ip_activities without limit' do
        begin
          activities = @client.get_ip_activities
          expect(activities).to be_a(
            SendGrid4r::REST::IpAccessManagement::IpActivities
          )
          activities.result.each do |activity|
            expect(activity).to be_a(
              SendGrid4r::REST::IpAccessManagement::IpActivity
            )
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_ip_activities with limit' do
        begin
          activities = @client.get_ip_activities(limit: 1)
          expect(activities).to be_a(
            SendGrid4r::REST::IpAccessManagement::IpActivities
          )
          activities.result.each do |activity|
            expect(activity).to be_a(
              SendGrid4r::REST::IpAccessManagement::IpActivity
            )
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_whitelisted_ips' do
        begin
          ips = @client.get_whitelisted_ips
          expect(ips).to be_a(
            SendGrid4r::REST::IpAccessManagement::WhitelistedIps
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#post_whitelisted_ips' do
        begin
          ips = @client.post_whitelisted_ips(ips: ['127.0.0.1'])
          expect(ips).to be_a(
            SendGrid4r::REST::IpAccessManagement::WhitelistedIps
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_whitelisted_ips' do
        begin
          @client.delete_whitelisted_ips(ids: [@id1])
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_whitelisted_ip' do
        begin
          whitelisted_ip = @client.get_whitelisted_ip(rule_id: @id1)
          expect(whitelisted_ip).to be_a(
            SendGrid4r::REST::IpAccessManagement::WhitelistedIp
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_whitelisted_ip' do
        begin
          expect do
            @client.delete_whitelisted_ip(rule_id: @id1)
          end.to raise_error(RestClient::ResourceNotFound)
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

    let(:ip_activities) do
      JSON.parse(
        '{'\
          '"result": ['\
            '{'\
              '"allowed": false,'\
              '"auth_method": "basic",'\
              '"first_at": 1444087966,'\
              '"ip": "1.1.1.1",'\
              '"last_at": 1444406672,'\
              '"location": "Australia"'\
            '}, {'\
              '"allowed": false,'\
              '"auth_method": "basic",'\
              '"first_at": 1444087505,'\
              '"ip": "1.2.3.48",'\
              '"last_at": 1444087505,'\
              '"location": "Mukilteo, Washington"'\
            '}'\
          ']'\
        '}'
      )
    end

    let(:whitelisted_ips) do
      JSON.parse(
        '{'\
          '"result": ['\
            '{'\
              '"id": 1, "ip": "192.168.1.1/32", '\
              '"created_at": 1441824715, "updated_at": 1441824715'\
            '},'\
            '{'\
              '"id": 2, "ip": "192.168.1.2/32", '\
              '"created_at": 1441824715, "updated_at": 1441824715'\
            '},'\
            '{'\
              '"id": 3, "ip": "192.168.1.3/32", '\
              '"created_at": 1441824715, "updated_at": 1441824715'\
            '}'\
          ']'\
        '}'
      )
    end

    let(:whitelisted_ip) do
      JSON.parse(
        '{'\
          '"id": 1,'\
          '"ip": "192.168.1.1",'\
          '"created_at": 1441824715,'\
          '"updated_at": 1441824715'\
        '}'
      )
    end

    it '#get_ip_activities' do
      allow(client).to receive(:execute).and_return(ip_activities)
      actual = client.get_ip_activities
      expect(actual).to be_a(SendGrid4r::REST::IpAccessManagement::IpActivities)
      actual.result.each do |activity|
        expect(activity).to be_a(
          SendGrid4r::REST::IpAccessManagement::IpActivity
        )
      end
    end

    it '#get_whitelisted_ips' do
      allow(client).to receive(:execute).and_return(whitelisted_ips)
      actual = client.get_whitelisted_ips
      expect(actual).to be_a(
        SendGrid4r::REST::IpAccessManagement::WhitelistedIps
      )
      actual.result.each do |whitelisted_ip|
        expect(whitelisted_ip).to be_a(
          SendGrid4r::REST::IpAccessManagement::WhitelistedIp
        )
      end
    end

    it '#post_whitelisted_ips' do
      allow(client).to receive(:execute).and_return(whitelisted_ips)
      actual = client.post_whitelisted_ips(ips: [''])
      expect(actual).to be_a(
        SendGrid4r::REST::IpAccessManagement::WhitelistedIps
      )
      actual.result.each do |whitelisted_ip|
        expect(whitelisted_ip).to be_a(
          SendGrid4r::REST::IpAccessManagement::WhitelistedIp
        )
      end
    end

    it '#delete_whitelisted_ips' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_whitelisted_ips(ids: [''])
      expect(actual).to eq('')
    end

    it '#get_whitelisted_ip' do
      allow(client).to receive(:execute).and_return(whitelisted_ip)
      actual = client.get_whitelisted_ip(rule_id: '')
      expect(actual).to be_a(
        SendGrid4r::REST::IpAccessManagement::WhitelistedIp
      )
    end

    it '#delete_whitelisted_ip' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_whitelisted_ip(rule_id: '')
      expect(actual).to eq('')
    end

    it 'creates ip_activities instance' do
      actual = SendGrid4r::REST::IpAccessManagement.create_ip_activities(
        ip_activities
      )
      expect(actual.result.length).to eq(2)
      activity0 = actual.result[0]
      expect(activity0.allowed).to eq(false)
      expect(activity0.auth_method).to eq('basic')
      expect(activity0.first_at).to eq(Time.at(1444087966))
      expect(activity0.ip).to eq('1.1.1.1')
      expect(activity0.last_at).to eq(Time.at(1444406672))
      expect(activity0.location).to eq('Australia')
    end

    it 'creates whitelisted_ips instance' do
      actual = SendGrid4r::REST::IpAccessManagement.create_whitelisted_ips(
        whitelisted_ips
      )
      expect(actual.result.length).to eq(3)
      ip1 = actual.result[0]
      expect(ip1.id).to eq(1)
      expect(ip1.ip).to eq('192.168.1.1/32')
      expect(ip1.created_at).to eq(Time.at(1441824715))
      expect(ip1.updated_at).to eq(Time.at(1441824715))
    end
  end
end
