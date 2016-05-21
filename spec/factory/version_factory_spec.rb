# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe VersionFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it 'is simple case' do
        version = VersionFactory.new.create(name: 'version_name')
        expect(version.name).to eq('version_name')
        expect(version.subject).to eq('<%subject%>')
        expect(version.html_content).to eq('<%body%>')
        expect(version.plain_content).to eq('<%body%>')
        expect(version.active).to eq(1)
      end

      it 'is full params case' do
        version = VersionFactory.new.create(
          name: 'version_name',
          subject: 'This is subject <%subject%>',
          html_content: 'This is html content <%body%>',
          plain_content: 'This is plain content <%body%>',
          active: 0
        )
        expect(version.name).to eq('version_name')
        expect(version.subject).to eq('This is subject <%subject%>')
        expect(version.html_content).to eq('This is html content <%body%>')
        expect(version.plain_content).to eq('This is plain content <%body%>')
        expect(version.active).to eq(0)
      end
    end
  end
end
