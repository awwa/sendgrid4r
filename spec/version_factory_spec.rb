# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe 'SendGrid4r::VersionFactory' do
  before :all do
    Dotenv.load
    @factory = SendGrid4r::VersionFactory.new
  end

  context 'always' do
    it 'is simple case' do
      version = @factory.create('version_name')
      expect(version.name).to eq('version_name')
      expect(version.subject).to eq('<%subject%>')
      expect(version.html_content).to eq('<%body%>')
      expect(version.plain_content).to eq('<%body%>')
      expect(version.active).to eq(1)
    end

    it 'is full params case' do
      version = @factory.create(
        'version_name',
        'This is subject <%subject%>',
        'This is html content <%body%>',
        'This is plain content <%body%>',
        0
      )
      expect(version.name).to eq('version_name')
      expect(version.subject).to eq('This is subject <%subject%>')
      expect(version.html_content).to eq('This is html content <%body%>')
      expect(version.plain_content).to eq('This is plain content <%body%>')
      expect(version.active).to eq(0)
    end
  end
end
