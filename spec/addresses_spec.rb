# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Ips::Addresses" do

  before :all do
    Dotenv.load
  end

  context "if account is free" do
    before :all do
      @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
    end

    describe "#get_ips" do
      it "raise error" do
        expect{@client.get_ips}.to raise_error(RestClient::Forbidden)
      end
    end

    describe "#get_ip" do
      it "raise error" do
        expect{@client.get_ip("10.10.10.10").to raise_error(RestClient::Forbidden)}
      end
    end
  end

  context "if account is silver" do
    before :all do
      @client = SendGrid4r::Client.new(ENV["SILVER_SENDGRID_USERNAME"], ENV["SILVER_SENDGRID_PASSWORD"])
    end

    describe "#get_ips" do
      it "returns Array of Address instance" do
        ips = @client.get_ips
        expect(ips.length > 0).to be(true)
        expect(ips[0].class).to be(SendGrid4r::REST::Ips::Address)
      end
    end

    describe "#get_ip" do
      it "returns Address instance" do
        ips = @client.get_ips
        expect(@client.get_ip(ips[0].ip).class).to be(SendGrid4r::REST::Ips::Address)
      end
    end

  end
end
