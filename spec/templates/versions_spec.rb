# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Templates::Versions' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD']
    )
    @template_name = 'version_test'
    @version1_name = 'version_name1'
    @version2_name = 'version_name2'
    @factory = SendGrid4r::Factory::VersionFactory.new
  end

  context 'without block call' do
    before :all do
      begin
        # celan up test env
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          next if tmp.name != @template_name
          tmp.versions.each do |ver|
            @client.delete_version(tmp.id, ver.id)
          end
          @client.delete_template(tmp.id)
        end
        # post a template
        @template = @client.post_template(@template_name)
        # post a version
        ver1 = @factory.create(name: @version1_name)
        @version1 = @client.post_version(@template.id, ver1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_version' do
      begin
        ver2 = @factory.create(name: @version2_name)
        version2 = @client.post_version(@template.id, ver2)
        expect(version2.name).to eq(@version2_name)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_version' do
      begin
        actual = @client.get_version(@template.id, @version1.id)
        expect(actual.template_id).to eq(@version1.template_id)
        expect(actual.active).to be_a(Fixnum)
        expect(actual.name).to eq(@version1.name)
        expect(actual.html_content).to eq(@version1.html_content)
        expect(actual.plain_content).to eq(@version1.plain_content)
        expect(actual.subject).to eq(@version1.subject)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#patch_version' do
      begin
        edit_ver1 = @version1.dup
        edit_ver1.name = 'edit_version'
        edit_ver1.subject = 'edit<%subject%>edit'
        edit_ver1.html_content = 'edit<%body%>edit'
        edit_ver1.plain_content = 'edit<%body%>edit'
        edit_ver1.active = 0
        @client.patch_version(@template.id, @version1.id, edit_ver1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_version' do
      begin
        @client.delete_version(@template.id, @version1.id)
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end
end
