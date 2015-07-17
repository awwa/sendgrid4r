# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Templates::Versions do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @template_name = 'version_test'
        @version1_name = 'version_name1'
        @version2_name = 'version_name2'
        @factory = SendGrid4r::Factory::VersionFactory.new

        # celan up test env
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          next if tmp.name != @template_name
          tmp.versions.each do |ver|
            @client.delete_version(template_id: tmp.id, version_id: ver.id)
          end
          @client.delete_template(template_id: tmp.id)
        end
        # post a template
        @template = @client.post_template(name: @template_name)
        # post a version
        ver1 = @factory.create(name: @version1_name)
        @version1 = @client.post_version(
          template_id: @template.id, version: ver1
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#post_version' do
        begin
          ver2 = @factory.create(name: @version2_name)
          version2 = @client.post_version(
            template_id: @template.id, version: ver2
          )
          expect(version2.name).to eq(@version2_name)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#activate_version' do
        begin
          actual = @client.activate_version(
            template_id: @template.id, version_id: @version1.id
          )
          expect(actual.active).to eq(1)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_version' do
        begin
          actual = @client.get_version(
            template_id: @template.id, version_id: @version1.id
          )
          expect(actual.template_id).to eq(@version1.template_id)
          expect(actual.active).to be_a(Fixnum)
          expect(actual.name).to eq(@version1.name)
          expect(actual.html_content).to eq(@version1.html_content)
          expect(actual.plain_content).to eq(@version1.plain_content)
          expect(actual.subject).to eq(@version1.subject)
        rescue RestClient::ExceptionWithResponse => e
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
          @client.patch_version(
            template_id: @template.id, version_id: @version1.id,
            version: edit_ver1
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_version' do
        begin
          @client.delete_version(
            template_id: @template.id, version_id: @version1.id
          )
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#post_version' do
        ver2 = @factory.create(name: @version2_name)
        @client.post_version(
          template_id: @template.id, version: ver2
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Templates::Versions.create_version(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Templates::Versions::Version)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#activate_version' do
        @client.activate_version(
          template_id: @template.id, version_id: @version1.id
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Templates::Versions.create_version(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Templates::Versions::Version)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_version' do
        @client.get_version(
          template_id: @template.id, version_id: @version1.id
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Templates::Versions.create_version(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Templates::Versions::Version)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#patch_version' do
        edit_ver1 = @version1.dup
        edit_ver1.name = 'edit_version'
        edit_ver1.subject = 'edit<%subject%>edit'
        edit_ver1.html_content = 'edit<%body%>edit'
        edit_ver1.plain_content = 'edit<%body%>edit'
        edit_ver1.active = 0
        @client.patch_version(
          template_id: @template.id, version_id: @version1.id,
          version: edit_ver1
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Templates::Versions.create_version(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Templates::Versions::Version)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_version' do
        @client.delete_version(
          template_id: @template.id, version_id: @version1.id
        ) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:version) do
      JSON.parse(
        '{'\
          '"id": "8aefe0ee-f12b-4575-b5b7-c97e21cb36f3",'\
          '"template_id": "ddb96bbc-9b92-425e-8979-99464621b543",'\
          '"active": 1,'\
          '"name": "example_version_name",'\
          '"html_content": "<%body%>",'\
          '"plain_content": "<%body%>",'\
          '"subject": "<%subject%>",'\
          '"updated_at": "2014-03-19 18:56:33"'\
        '}'
      )
    end

    it '#post_version' do
      allow(client).to receive(:execute).and_return(version)
      actual = client.post_version(template_id: '', version: nil)
      expect(actual).to be_a(SendGrid4r::REST::Templates::Versions::Version)
    end

    it '#activate_version' do
      allow(client).to receive(:execute).and_return(version)
      actual = client.activate_version(template_id: '', version_id: '')
      expect(actual).to be_a(SendGrid4r::REST::Templates::Versions::Version)
    end

    it '#get_version' do
      allow(client).to receive(:execute).and_return(version)
      actual = client.get_version(template_id: '', version_id: '')
      expect(actual).to be_a(SendGrid4r::REST::Templates::Versions::Version)
    end

    it '#patch_version' do
      allow(client).to receive(:execute).and_return(version)
      actual = client.patch_version(
        template_id: '', version_id: '', version: nil
      )
      expect(actual).to be_a(SendGrid4r::REST::Templates::Versions::Version)
    end

    it '#delete_version' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_version(template_id: '', version_id: '')
      expect(actual).to eq('')
    end

    it 'creates version instance' do
      actual = SendGrid4r::REST::Templates::Versions.create_version(version)
      expect(actual).to be_a(SendGrid4r::REST::Templates::Versions::Version)
      expect(actual.id).to eq('8aefe0ee-f12b-4575-b5b7-c97e21cb36f3')
      expect(actual.template_id).to eq('ddb96bbc-9b92-425e-8979-99464621b543')
      expect(actual.active).to eq(1)
      expect(actual.name).to eq('example_version_name')
      expect(actual.html_content).to eq('<%body%>')
      expect(actual.plain_content).to eq('<%body%>')
      expect(actual.subject).to eq('<%subject%>')
      expect(actual.updated_at).to eq('2014-03-19 18:56:33')
    end
  end
end
