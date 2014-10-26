# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::Groups" do

  GROUP_NAME = "group_test"
  GROUP_EDIT = "group_edit"
  GROUP_DESC = "group_desc"
  GROUP_DESC_EDIT = "group_desc_edit"

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
        if grp.name == GROUP_NAME || grp.name == GROUP_EDIT then
          @client.delete_group(grp.id)
        end
      }
      # post a group
      new_group = @client.post_group(GROUP_NAME, GROUP_DESC)
      expect(GROUP_NAME).to eq(new_group.name)
      expect(GROUP_DESC).to eq(new_group.description)
      # patch the group
      new_group.name = GROUP_EDIT
      new_group.description = GROUP_DESC_EDIT
      @client.patch_group(new_group.id, new_group)
      # get the group
      edit_group = @client.get_group(new_group.id)
      expect(edit_group.respond_to?("id")).to eq(true)
      expect(edit_group.respond_to?("name")).to eq(true)
      expect(edit_group.respond_to?("description")).to eq(true)
      expect(edit_group.respond_to?("last_email_sent_at")).to eq(true)
      expect(edit_group.respond_to?("unsubscribes")).to eq(true)
      expect(new_group.id).to eq(edit_group.id)
      expect(GROUP_EDIT).to eq(edit_group.name)
      expect(GROUP_DESC_EDIT).to eq(edit_group.description)
      # delete the group
      @client.delete_group(edit_group.id)
      expect{@client.get_group(edit_group.id)}.to raise_error(RestClient::ResourceNotFound)
    end
  end

  context "abnormal" do
    it "raise resource not found for none existance id" do
      expect{@client.get_group("notexistid")}.to raise_error(RestClient::ResourceNotFound)
    end
  end
end
