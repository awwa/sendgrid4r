# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Templates::Versions" do

  TEMPLATE_NAME = "version_test"
  VERSION1_NAME = "version1_test"
  VERSION2_NAME = "version2_test"

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do
    it "is normal" do
      # celan up test env
      tmps = @client.get_templates
      tmps.each{|tmp|
        if tmp.name == TEMPLATE_NAME then
          tmp.versions.each{|ver|
            @client.delete_version(tmp.id, ver.id)
          }
          @client.delete_template(tmp.id)
        end
      }
      # post a template
      new_template = @client.post_template(TEMPLATE_NAME)
      expect(TEMPLATE_NAME).to eq(new_template.name)
      # post a version
      factory = SendGrid4r::VersionFactory.new
      ver1 = factory.create(VERSION1_NAME)
      ver1 = @client.post_version(new_template.id, ver1)
      # get the version
      actual = @client.get_version(new_template.id, ver1.id)
      expect(ver1.template_id).to eq(actual.template_id)
      expect(ver1.active).to eq(actual.active)
      expect(ver1.name).to eq(actual.name)
      expect(ver1.html_content).to eq(actual.html_content)
      expect(ver1.plain_content).to eq(actual.plain_content)
      expect(ver1.subject).to eq(actual.subject)
      # edit the version
      edit_ver1 = actual.dup
      edit_ver1.name = "edit_version"
      edit_ver1.subject = "edit<%subject%>edit"
      edit_ver1.html_content = "edit<%body%>edit"
      edit_ver1.plain_content = "edit<%body%>edit"
      edit_ver1.active = 0
      @client.patch_version(new_template.id, ver1.id, edit_ver1)
      # get the version
      actual = @client.get_version(new_template.id, ver1.id)
      expect(new_template.id).to eq(actual.template_id)
      expect(edit_ver1.active).to eq(actual.active)
      expect(edit_ver1.name).to eq(actual.name)
      expect(edit_ver1.html_content).to eq(actual.html_content)
      expect(edit_ver1.plain_content).to eq(actual.plain_content)
      expect(edit_ver1.subject).to eq(actual.subject)
      # post a version 2
      ver2 = factory.create(VERSION2_NAME, "<%subject%>", "<%body%>", "<%body%>")
      ver2 = @client.post_version(new_template.id, ver2)
      # activate version 2
      @client.activate_version(new_template.id, ver2.id)
      actual_ver1 = @client.get_version(new_template.id, ver1.id)
      actual_ver2 = @client.get_version(new_template.id, ver2.id)
      expect(0).to eq(actual_ver1.active)
      expect(1).to eq(actual_ver2.active)
      # delete the version
      @client.delete_version(new_template.id, actual_ver1.id)
      @client.delete_version(new_template.id, actual_ver2.id)
      expect{@client.get_version(new_template.id, actual_ver1.id)}.to raise_error(RestClient::ResourceNotFound)
      expect{@client.get_version(new_template.id, actual_ver2.id)}.to raise_error(RestClient::ResourceNotFound)
      # delete the template
      @client.delete_template(new_template.id)
    end
  end
end
