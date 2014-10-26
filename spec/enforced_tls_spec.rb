# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Settings::EnforcedTls" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do

    describe "#get_enforced_tls" do
      it "returns EnforcedTls instance" do
        actual = @client.get_enforced_tls
        expect(actual.class).to be(SendGrid4r::REST::Settings::EnforcedTls::EnforcedTls)
      end
    end

    describe "#patch_enforced_tls" do
      it "update EnforcedTls values" do
        # get original enforced_tls settings
        actual = @client.get_enforced_tls
        # patch both value
        actual.require_tls = false
        actual.require_valid_cert = false
        edit = @client.patch_enforced_tls(actual)
        expect(actual.require_tls).to eq(edit.require_tls)
        expect(actual.require_valid_cert).to eq(edit.require_valid_cert)
      end
    end
  end
end
