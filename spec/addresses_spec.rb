# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Ips::Addresses" do

  before :all do
    Dotenv.load
  end

  context "free account" do
    it "raise error for get_ips" do

      begin
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # get the ips
        expect{client.get_ips}.to raise_error(RestClient::Forbidden)
        # get the ip
        expect{client.get_ip("10.10.10.10").to raise_error(RestClient::Forbidden)}
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end

  end

  context "silver account" do
    it "returns Array of Address instance" do

      begin
        client = SendGrid4r::Client.new(ENV["SILVER_SENDGRID_USERNAME"], ENV["SILVER_SENDGRID_PASSWORD"])
        # get the ips
        ips = client.get_ips
        expect(ips.length).to be(1)
        expect(ips[0].class).to be(SendGrid4r::REST::Ips::Address)
        expect(client.get_ip(ips[0].ip).class).to be(SendGrid4r::REST::Ips::Address)
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end

  end

end
