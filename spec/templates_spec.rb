# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Templates" do

  TEMPLATE_NAME = "template_test"
  TEMPLATE_EDIT = "template_edit"

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do
    it "is normal" do
      # celan up test env
      tmps = @client.get_templates
      expect(tmps.length >= 0).to eq(true)
      tmps.each{|tmp|
        if tmp.name == TEMPLATE_NAME || tmp.name == TEMPLATE_EDIT then
          @client.delete_template(tmp.id)
        end
      }
      # post a template
      new_template = @client.post_template(TEMPLATE_NAME)
      expect(TEMPLATE_NAME).to eq(new_template.name)
      # pach the template
      @client.patch_template(new_template.id, TEMPLATE_EDIT)
      # get the template
      edit_template = @client.get_template(new_template.id)
      expect(new_template.id).to eq(edit_template.id)
      expect(TEMPLATE_EDIT).to eq(edit_template.name)
      expect(new_template.versions).to eq(edit_template.versions)
      # delete the template
      @client.delete_template(edit_template.id)
      expect{@client.get_template(edit_template.id)}.to raise_error(RestClient::ResourceNotFound)
    end
  end
end
