# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::Settings
  describe SendGrid4r::REST::Settings do
    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:results) do
        JSON.parse(
          '{'\
            '"result": ['\
              '{'\
                '"name": "bcc",'\
                '"title": "BCC",'\
                '"description": "lorem ipsum... .",'\
                '"enabled": true'\
              '}'\
            ']'\
          '}'
        )
      end

      let(:result) do
        JSON.parse(
          '{'\
            '"name": "bcc",'\
            '"title": "BCC",'\
            '"description": "lorem ipsum... .",'\
            '"enabled": true'\
          '}'
        )
      end

      it 'creates results instance' do
        actual = SendGrid4r::REST::Settings.create_results(results)
        expect(actual.result).to be_a(Array)
        actual.result.each do |result|
          expect(result).to be_a(Result)
        end
      end

      it 'creates result instance' do
        actual = SendGrid4r::REST::Settings.create_result(result)
        expect(actual).to be_a(Result)
        expect(actual.name).to eq('bcc')
        expect(actual.title).to eq('BCC')
        expect(actual.description).to eq('lorem ipsum... .')
        expect(actual.enabled).to eq(true)
      end
    end
  end
end
