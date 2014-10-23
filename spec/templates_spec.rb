# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Templates" do

  before :all do
    Dotenv.load
    @template_name = "template_test"
    @template_edit = "template_edit"
  end

  context "normal" do
    it "is normal" do

      begin
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # celan up test env
        tmps = client.get_templates
        expect(tmps.length >= 0).to eq(true)
        tmps.each{|tmp|
          if tmp.name == @template_name || tmp.name == @template_edit then
            client.delete_template(tmp.id)
          end
        }
        # post a template
        new_template = client.post_template(@template_name)
        expect(@template_name).to eq(new_template.name)
        # pach the template
        client.patch_template(new_template.id, @template_edit)
        # get the template
        edit_template = client.get_template(new_template.id)
        expect(new_template.id).to eq(edit_template.id)
        expect(@template_edit).to eq(edit_template.name)
        expect(new_template.versions).to eq(edit_template.versions)
        # delete the template
        client.delete_template(edit_template.id)
        expect{client.get_template(edit_template.id)}.to raise_error(RestClient::ResourceNotFound)
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end
  end

  context "abnormal" do
    it "raise resource not found for none existance id" do
      client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
      expect{client.get_template("notexistid")}.to raise_error(RestClient::ResourceNotFound)
    end
  end

end
