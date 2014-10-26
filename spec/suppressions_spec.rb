# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::Groups::Suppressions" do

  EMAIL1 = "test1@test.com"
  EMAIL2 = "test2@test.com"
  EMAIL3 = "test3@test.com"
  GROUP_NAME = "suppressions_test"
  GROUP_DESC = "group_desc"

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do
    it "is normal" do
      # celan up test env
      grps = @client.get_groups
      expect(grps.length >= 0).to eq(true)
      grps.each{|grp|
        if grp.name == GROUP_NAME then
          emails = @client.get_suppressed_emails(grp.id)
          emails.each{|email|
            @client.delete_suppressed_email(grp.id, email)
          }
          @client.delete_group(grp.id)
        end
      }
      # post a group
      new_group = @client.post_group(GROUP_NAME, GROUP_DESC)
      # post recipient emails to the suppression group
      suppressed_emails = @client.post_suppressed_emails(new_group.id, [EMAIL1, EMAIL2, EMAIL3])
      expect(suppressed_emails.length).to eq(3)
      expect(suppressed_emails[0]).to eq(EMAIL1)
      expect(suppressed_emails[1]).to eq(EMAIL2)
      expect(suppressed_emails[2]).to eq(EMAIL3)
      # get the suppressions
      suppressions = @client.get_suppressions(EMAIL1)
      expect(suppressions.length>1).to eq(true)
      expect(suppressions[0].name).to eq(GROUP_NAME)
      expect(suppressions[0].description).to eq(GROUP_DESC)
      expect(suppressions[0].suppressed).to eq(true)
      # get the recipient emails
      actual_emails = @client.get_suppressed_emails(new_group.id)
      expect(actual_emails.length).to eq(suppressed_emails.length)
      expect(actual_emails[0]).to eq(suppressed_emails[0])
      expect(actual_emails[1]).to eq(suppressed_emails[1])
      expect(actual_emails[2]).to eq(suppressed_emails[2])
      # delete the suppressed email
      @client.delete_suppressed_email(new_group.id, EMAIL1)
      @client.delete_suppressed_email(new_group.id, EMAIL2)
      @client.delete_suppressed_email(new_group.id, EMAIL3)
      # delete the group
      @client.delete_group(new_group.id)
      expect{@client.get_group(new_group.id)}.to raise_error(RestClient::ResourceNotFound)
    end
  end
end
