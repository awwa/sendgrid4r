# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::Client" do

  before :all do
    Dotenv.load
  end

  context "always" do

    describe "initialize" do
      it "create instance" do
        client = SendGrid4r::Client.new("username", "password")
        expect(client.class).to eq(SendGrid4r::Client)
      end
    end

    describe "methods" do
      it "available" do
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # Advanced Suppression Manager
        # groups
        expect(client.respond_to?("get_groups")).to eq(true)
        expect(client.respond_to?("get_group")).to eq(true)
        expect(client.respond_to?("post_group")).to eq(true)
        expect(client.respond_to?("patch_group")).to eq(true)
        expect(client.respond_to?("delete_group")).to eq(true)
        # suppressions
        expect(client.respond_to?("post_suppressed_emails")).to eq(true)
        expect(client.respond_to?("get_suppressions")).to eq(true)
        expect(client.respond_to?("get_suppressed_emails")).to eq(true)
        expect(client.respond_to?("delete_suppressed_email")).to eq(true)
        # global suppressions
        expect(client.respond_to?("post_global_suppressed_emails")).to eq(true)
        expect(client.respond_to?("get_global_suppressed_email")).to eq(true)
        expect(client.respond_to?("delete_global_suppressed_email")).to eq(true)
        # IP Management
        # ip addresses
        expect(client.respond_to?("get_ips")).to eq(true)
        expect(client.respond_to?("get_ip")).to eq(true)
        expect(client.respond_to?("post_ip_to_pool")).to eq(true)
        expect(client.respond_to?("delete_ip_from_pool")).to eq(true)
        # pool
        expect(client.respond_to?("get_pools")).to eq(true)
        expect(client.respond_to?("post_pool")).to eq(true)
        expect(client.respond_to?("get_pool")).to eq(true)
        expect(client.respond_to?("put_pool")).to eq(true)
        expect(client.respond_to?("delete_pool")).to eq(true)
        # warmup
        expect(client.respond_to?("get_warmup_ips")).to eq(true)
        expect(client.respond_to?("get_warmup_ip")).to eq(true)
        expect(client.respond_to?("post_warmup_ip")).to eq(true)
        expect(client.respond_to?("delete_warmup_ip")).to eq(true)
        # Settings
        # enforced_tls
        expect(client.respond_to?("get_enforced_tls")).to eq(true)
        expect(client.respond_to?("patch_enforced_tls")).to eq(true)
        # Template Engine
        # templates
        expect(client.respond_to?("get_templates")).to eq(true)
        expect(client.respond_to?("get_template")).to eq(true)
        expect(client.respond_to?("post_template")).to eq(true)
        expect(client.respond_to?("patch_template")).to eq(true)
        expect(client.respond_to?("delete_template")).to eq(true)
        # versions
        expect(client.respond_to?("get_version")).to eq(true)
        expect(client.respond_to?("post_version")).to eq(true)
        expect(client.respond_to?("activate_version")).to eq(true)
        expect(client.respond_to?("patch_version")).to eq(true)
        expect(client.respond_to?("delete_version")).to eq(true)
      end
    end

    describe "Version" do
      it "VERSION" do
        expect(SendGrid4r::VERSION).to eq("0.0.4")
      end
    end

  end
end
