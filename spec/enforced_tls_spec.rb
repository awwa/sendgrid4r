# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Settings::EnforcedTls" do

  before :all do
    Dotenv.load
  end

  context "normal" do
    it "is normal" do

      begin
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # get original enforced_tls settings
        original = client.get_enforced_tls
        # patch a value
        edit_params = original.dup
        edit_params.require_tls = true
        actual_params = client.patch_enforced_tls(edit_params)
        expect(actual_params.require_tls).to eq(edit_params.require_tls)
        # patch both value
        edit_params.require_tls = false
        edit_params.require_valid_cert = false
        actual_params = client.patch_enforced_tls(edit_params)
        expect(actual_params.require_tls).to eq(edit_params.require_tls)
        expect(actual_params.require_valid_cert).to eq(edit_params.require_valid_cert)
        # revert
        client.patch_enforced_tls(original)
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end
  end

end
