# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Ips::WarmUp' do
  before :all do
    Dotenv.load
  end

  context 'normal' do
    it 'is normal' do
      begin
        client = SendGrid4r::Client.new(
          ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
        # celan up test env
        warmup_ips = client.get_warmup_ips
        expect(warmup_ips.length >= 0).to eq(true)
        if warmup_ips.length > 0
          warmup_ips.each do |warmup_ip|
            client.delete_warmup_ip(warmup_ip.ip)
          end
        end
        # get warmup ip
        warmup_ips = client.get_warmup_ips
        expect(warmup_ips.length).to eq(0)
        # post warmup ip
        ips = client.get_ips
        if ips.length > 0
          warmup_ip = client.post_warmup_ip(ips[0].ip)
          expect(warmup_ip.ip).to eq(ips[0].ip)
        end
        warmup_ip = client.get_warmup_ip(warmup_ip.ip)
        expect(warmup_ip.ip).to eq(ips[0].ip)
        # delete the warmup ip
        client.delete_warmup_ip(warmup_ip.ip)
        expect do
          client.get_warmup_ip(warmup_ip.ip)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => ex
        puts ex.inspect
        raise ex
      end
    end
  end

  context 'abnormal' do
    it 'raise forbidden for free account' do
      client = SendGrid4r::Client.new(
        ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
      expect { client.get_warmup_ips }.to raise_error(RestClient::Forbidden)
    end
  end
end
