# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::GlobalSuppressions" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
    @email1 = "test1@test.com"
    @email2 = "test2@test.com"
    @email3 = "test3@test.com"
  end

  context "always" do
    it "is normal" do
      # celan up test env
      actual_email1 = @client.get_global_suppressed_email(@email1)
      actual_email2 = @client.get_global_suppressed_email(@email2)
      actual_email3 = @client.get_global_suppressed_email(@email3)
      @client.delete_global_suppressed_email(@email1) if actual_email1 == @email1
      @client.delete_global_suppressed_email(@email2) if actual_email2 == @email2
      @client.delete_global_suppressed_email(@email3) if actual_email3 == @email3
      # post_global_suppressed_emails
      suppressed_emails = @client.post_global_suppressed_emails([@email1, @email2, @email3])
      expect(suppressed_emails.length).to eq(3)
      expect(suppressed_emails.include? @email1).to eq(true)
      expect(suppressed_emails.include? @email2).to eq(true)
      expect(suppressed_emails.include? @email3).to eq(true)
      # get_global_suppressed_email
      actual_email1 = @client.get_global_suppressed_email(@email1)
      actual_email2 = @client.get_global_suppressed_email(@email2)
      actual_email3 = @client.get_global_suppressed_email(@email3)
      actual_notexist = @client.get_global_suppressed_email("notexist")
      expect(actual_email1).to eq(@email1)
      expect(actual_email2).to eq(@email2)
      expect(actual_email3).to eq(@email3)
      expect(actual_notexist).to eq(nil)
      # delete_global_suppressed_email
      expect(@client.delete_global_suppressed_email(@email1)).to eq("")
      expect(@client.delete_global_suppressed_email(@email2)).to eq("")
      expect(@client.delete_global_suppressed_email(@email3)).to eq("")
    end
  end
end
