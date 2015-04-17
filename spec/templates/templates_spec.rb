# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Templates' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD']
    )
    @template_name1 = 'template_test1'
    @template_name2 = 'template_test2'
    @template_edit1 = 'template_edit1'
  end

  context 'without block call' do
    before :all do
      begin
        # celan up test env
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          @client.delete_template(tmp.id) if tmp.name == @template_name1
          @client.delete_template(tmp.id) if tmp.name == @template_name2
          @client.delete_template(tmp.id) if tmp.name == @template_edit1
        end
        # post a template
        @template1 = @client.post_template(@template_name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_template' do
      begin
        new_template = @client.post_template(@template_name2)
        expect(new_template.name).to eq(@template_name2)
        expect(new_template.versions).to be_a(Array)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_templates' do
      begin
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          expect(tmp.id).to be_a(String)
          expect(tmp.name).to be_a(String)
          expect(tmp.versions).to be_a(Array)
          tmp.versions.each do |ver|
            expect(ver.id).to be_a(String)
            expect(ver.template_id).to be_a(String)
            expect(ver.active).to be_a(Fixnum)
            expect(ver.name).to be_a(String)
            expect(ver.updated_at).to be_a(String)
          end
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#patch_template' do
      begin
        tmp = @client.patch_template(@template1.id, @template_edit1)
        expect(tmp.id).to be_a(String)
        expect(tmp.name).to be_a(String)
        expect(tmp.versions).to be_a(Array)
        tmp.versions.each do |ver|
          expect(ver.id).to be_a(String)
          expect(ver.template_id).to be_a(String)
          expect(ver.active).to be_a(Fixnum)
          expect(ver.name).to be_a(String)
          expect(ver.updated_at).to be_a(String)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_template' do
      begin
        tmp = @client.get_template(@template1.id)
        expect(tmp.id).to eq(@template1.id)
        expect(tmp.versions).to eq(@template1.versions)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_template' do
      begin
        @client.delete_template(@template1.id)
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    before :all do
      begin
        # celan up test env
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          @client.delete_template(tmp.id) if tmp.name == @template_name1
          @client.delete_template(tmp.id) if tmp.name == @template_name2
          @client.delete_template(tmp.id) if tmp.name == @template_edit1
        end
        # post a template
        @template1 = @client.post_template(@template_name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_template' do
      @client.post_template(@template_name2) do |resp, req, res|
        resp =
          SendGrid4r::REST::Templates.create_template(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Templates::Template)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end

    it '#get_templates' do
      @client.get_templates do |resp, req, res|
        resp =
          SendGrid4r::REST::Templates.create_templates(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Templates::Templates)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#patch_template' do
      @client.patch_template(@template1.id, @template_edit1) do |resp, req, res|
        resp =
          SendGrid4r::REST::Templates.create_template(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Templates::Template)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_template' do
      @client.get_template(@template1.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Templates.create_template(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Templates::Template)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#delete_template' do
      @client.delete_template(@template1.id) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end
  end

  context 'unit test' do
    it 'creates template instance' do
      json =
        '{'\
          '"id": "733ba07f-ead1-41fc-933a-3976baa23716",'\
          '"name": "example_name",'\
          '"versions": []'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Templates.create_template(hash)
      expect(actual.id).to eq('733ba07f-ead1-41fc-933a-3976baa23716')
      expect(actual.name).to eq('example_name')
      expect(actual.versions).to be_a(Array)
    end

    it 'creates templates instance' do
      json =
        '{'\
          '"templates": ['\
            '{'\
              '"id": "e8ac01d5-a07a-4a71-b14c-4721136fe6aa",'\
              '"name": "example template name",'\
              '"versions": ['\
                '{'\
                  '"id": "de37d11b-082a-42c0-9884-c0c143015a47",'\
                  '"user_id": 1234,'\
                  '"template_id": "d51480ba-ca3f-465c-bc3e-ceb71d73c38d",'\
                  '"active": 1,'\
                  '"name": "example version",'\
                  '"html_content": "<%body%><strong>Click to Reset</strong>",'\
                  '"plain_content": "Click to Reset<%body%>",'\
                  '"subject": "<%subject%>",'\
                  '"updated_at": "2014-05-22 20:05:21"'\
                '}'\
              ']'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Templates.create_templates(hash)
      expect(actual.templates).to be_a(Array)
      actual.templates.each do |template|
        expect(template.id).to eq('e8ac01d5-a07a-4a71-b14c-4721136fe6aa')
        expect(template.name).to eq('example template name')
        expect(template.versions).to be_a(Array)
        template.versions do |version|
          expect(version.id).to eq('de37d11b-082a-42c0-9884-c0c143015a47')
          expect(version.user_id).to eq(1234)
          expect(version.template_id).to eq(
            'd51480ba-ca3f-465c-bc3e-ceb71d73c38d'
          )
          expect(version.active).to eq(1)
          expect(version.name).to eq('example version')
          expect(version.html_content).to eq(
            '<%body%><strong>Click to Reset</strong>'
          )
          expect(version.plain_content).to eq('Click to Reset<%body%>')
          expect(version.subject).to eq('<%subject%>')
          expect(version.updated_at).to eq('2014-05-22 20:05:21')
        end
      end
    end
  end
end
