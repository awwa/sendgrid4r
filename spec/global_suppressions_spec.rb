# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::GlobalSuppressions" do

  EMAIL1 = "test1@test.com"
  EMAIL2 = "test2@test.com"
  EMAIL3 = "test3@test.com"

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
    # celan up test env
    @client.delete_global_suppressed_email(EMAIL1)
    @client.delete_global_suppressed_email(EMAIL2)
    @client.delete_global_suppressed_email(EMAIL3)
  end

  context "always" do
    it "is normal" do
      # post_global_suppressed_emails
      suppressed_emails = @client.post_global_suppressed_emails([EMAIL1, EMAIL2, EMAIL3])
      expect(suppressed_emails.length).to eq(3)
      expect(suppressed_emails[0]).to eq(EMAIL1)
      expect(suppressed_emails[1]).to eq(EMAIL2)
      expect(suppressed_emails[2]).to eq(EMAIL3)
      # get_global_suppressed_email
      actual_email1 = @client.get_global_suppressed_email(EMAIL1)
      actual_email2 = @client.get_global_suppressed_email(EMAIL2)
      actual_email3 = @client.get_global_suppressed_email(EMAIL3)
      actual_notexist = @client.get_global_suppressed_email("notexist")
      expect(actual_email1).to eq(EMAIL1)
      expect(actual_email2).to eq(EMAIL2)
      expect(actual_email3).to eq(EMAIL3)
      expect(actual_notexist).to eq(nil)
      # delete_global_suppressed_email
      expect(@client.delete_global_suppressed_email(EMAIL1)).to eq("")
      expect(@client.delete_global_suppressed_email(EMAIL2)).to eq("")
      expect(@client.delete_global_suppressed_email(EMAIL3)).to eq("")
    end
  end
end
