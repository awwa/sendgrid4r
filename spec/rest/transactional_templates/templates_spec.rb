# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::TransactionalTemplates
  describe SendGrid4r::REST::TransactionalTemplates do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @template_name1 = 'template_test1'
        @template_name2 = 'template_test2'
        @template_edit1 = 'template_edit1'
        @version_name1 = 'version_test1'
        @factory = SendGrid4r::Factory::VersionFactory.new

        # celan up test env
        tmps = @client.get_templates
        tmps.templates.each do |tmp|
          delete_template(tmp) if tmp.name == @template_name1
          delete_template(tmp) if tmp.name == @template_name2
          delete_template(tmp) if tmp.name == @template_edit1
        end
        # post a template
        @template1 = @client.post_template(name: @template_name1)
      end

      def delete_template(tmp)
        tmp.versions.each do |ver|
          @client.delete_version(template_id: tmp.id, version_id: ver.id)
        end
        @client.delete_template(template_id: tmp.id)
      end

      context 'without block call' do
        it '#post_template' do
          new_template = @client.post_template(name: @template_name2)
          expect(new_template.id).to be_a(String)
          expect(new_template.name).to eq(@template_name2)
          expect(new_template.versions).to be_a(Array)
        end

        it '#get_templates' do
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
        end

        it '#patch_template' do
          version = @factory.create(name: @version_name1)
          @client.post_version(template_id: @template1.id, version: version)
          tmp = @client.patch_template(
            template_id: @template1.id, name: @template_edit1
          )
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

        it '#get_template' do
          tmp = @client.get_template(template_id: @template1.id)
          expect(tmp.id).to eq(@template1.id)
          expect(tmp.versions).to eq(@template1.versions)
        end

        it '#delete_template' do
          @client.delete_template(template_id: @template1.id)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:template) do
        '{'\
          '"id": "733ba07f-ead1-41fc-933a-3976baa23716",'\
          '"name": "example_name",'\
          '"versions": []'\
        '}'
      end

      let(:templates) do
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
                  '"html_content": "<%body%><strong>Click '\
                    'to Reset</strong>",'\
                  '"plain_content": "Click to Reset<%body%>",'\
                  '"subject": "<%subject%>",'\
                  '"updated_at": "2014-05-22 20:05:21"'\
                '}'\
              ']'\
            '}'\
          ']'\
        '}'
      end

      it '#post_template' do
        allow(client).to receive(:execute).and_return(template)
        actual = client.post_template(name: '')
        expect(actual).to be_a(Template)
      end

      it '#get_templates' do
        allow(client).to receive(:execute).and_return(templates)
        actual = client.get_templates
        expect(actual).to be_a(Templates)
      end

      it '#patch_template' do
        allow(client).to receive(:execute).and_return(template)
        actual = client.patch_template(template_id: '', name: '')
        expect(actual).to be_a(Template)
      end

      it '#get_template' do
        allow(client).to receive(:execute).and_return(template)
        actual = client.get_template(template_id: '')
        expect(actual).to be_a(Template)
      end

      it '#delete_template' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_template(template_id: '')
        expect(actual).to eq('')
      end

      it 'creates template instance' do
        actual = SendGrid4r::REST::TransactionalTemplates.create_template(
          JSON.parse(template)
        )
        expect(actual).to be_a(Template)
        expect(actual.id).to eq('733ba07f-ead1-41fc-933a-3976baa23716')
        expect(actual.name).to eq('example_name')
        expect(actual.versions).to be_a(Array)
      end

      it 'creates templates instance' do
        actual = SendGrid4r::REST::TransactionalTemplates.create_templates(
          JSON.parse(templates)
        )
        expect(actual).to be_a(Templates)
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
end
