# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Templates" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
    @template_name = "template_test"
    @template_edit = "template_edit"
  end

  context "always" do
    it "is normal" do
      # celan up test env
      tmps = @client.get_templates
      expect(tmps.length >= 0).to eq(true)
      tmps.each{|tmp|
        if tmp.name == @template_name || tmp.name == @template_edit then
          @client.delete_template(tmp.id)
        end
      }
      # post a template
      new_template = @client.post_template(@template_name)
      expect(@template_name).to eq(new_template.name)
      expect([]).to eq(new_template.versions)
      # get all templates
      tmps = @client.get_templates
      tmps.each{|tmp|
        expect(false).to eq(tmp.id.nil?)
        expect(false).to eq(tmp.name.nil?)
        expect(true).to eq(tmp.versions.is_a?(Array))
        tmp.versions.each{|ver|
          expect(false).to eq(ver.id.nil?)
          expect(false).to eq(ver.template_id.nil?)
          expect(false).to eq(ver.active.nil?)
          expect(false).to eq(ver.name.nil?)
          expect(false).to eq(ver.updated_at.nil?)
        }
      }
      # pach the template
      edit_template = @client.patch_template(new_template.id, @template_edit)
      expect(false).to eq(edit_template.id.nil?)
      expect(false).to eq(edit_template.name.nil?)
      expect(true).to eq(edit_template.versions.is_a?(Array))
      edit_template.versions.each{|ver|
        expect(false).to eq(ver.id.nil?)
        expect(false).to eq(ver.template_id.nil?)
        expect(false).to eq(ver.active.nil?)
        expect(false).to eq(ver.name.nil?)
        expect(false).to eq(ver.updated_at.nil?)
      }
      # get the template
      edit_template = @client.get_template(new_template.id)
      expect(new_template.id).to eq(edit_template.id)
      expect(@template_edit).to eq(edit_template.name)
      expect(new_template.versions).to eq(edit_template.versions)
      # delete the template
      @client.delete_template(edit_template.id)
      expect{@client.get_template(edit_template.id)}.to raise_error(RestClient::ResourceNotFound)
    end
  end
end
