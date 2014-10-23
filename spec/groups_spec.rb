# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::Groups" do

  before :all do
    Dotenv.load
    @group_name = "group_test"
    @group_edit = "group_edit"
    @group_desc = "group_desc"
    @group_desc_edit = "group_desc_edit"
  end

  context "normal" do
    it "is normal" do

      begin
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # celan up test env
        grps = client.get_groups
        expect(grps.length >= 0).to eq(true)
        grps.each{|grp|
          if grp.name == @group_name || grp.name == @group_edit then
            client.delete_group(grp.id)
          end
        }
        # post a group
        new_group = client.post_group(@group_name, @group_desc)
        expect(@group_name).to eq(new_group.name)
        expect(@group_desc).to eq(new_group.description)
        # pach the group
        new_group.name = @group_edit
        new_group.description = @group_desc_edit
        client.patch_group(new_group.id, new_group)
        # get the group
        edit_group = client.get_group(new_group.id)
        expect(edit_group.respond_to?("id")).to eq(true)
        expect(edit_group.respond_to?("name")).to eq(true)
        expect(edit_group.respond_to?("description")).to eq(true)
        expect(edit_group.respond_to?("last_email_sent_at")).to eq(true)
        expect(edit_group.respond_to?("unsubscribes")).to eq(true)
        expect(new_group.id).to eq(edit_group.id)
        expect(@group_edit).to eq(edit_group.name)
        expect(@group_desc_edit).to eq(edit_group.description)
        # delete the group
        client.delete_group(edit_group.id)
        expect{client.get_group(edit_group.id)}.to raise_error(RestClient::ResourceNotFound)
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end
  end

  context "abnormal" do
    it "raise resource not found for none existance id" do
      client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
      expect{client.get_group("notexistid")}.to raise_error(RestClient::ResourceNotFound)
    end
  end

end
