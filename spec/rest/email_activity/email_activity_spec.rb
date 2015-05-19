# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::EmailActivity do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(
          username: ENV['SENDGRID_USERNAME'],
          password: ENV['SENDGRID_PASSWORD'])
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_email_activities' do
        begin
          activities = @client.get_email_activities
          activities.each do |activity|
            expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block call' do
      it '#get_email_activities' do
        @client.get_api_keys do |resp, req, res|
          resp =
            SendGrid4r::REST::ApiKeys.create_api_keys(JSON.parse(resp))
          expect(resp).to be_a(SendGrid4r::REST::ApiKeys::ApiKeys)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:activities) do
      JSON.parse(
        '['\
          '{'\
            '"email": "test@example.com",'\
            '"event": "processed",'\
            '"created": 1431624000,'\
            '"category": ["my_category"],'\
            '"smtp_id": "filter001-2348927389",'\
            '"asm_group_id": null,'\
            '"msg_id": "xxx-abc-123",'\
            '"ip": null,'\
            '"url": null'\
          '}'\
        ']'
      )
    end

    let(:activity) do
      JSON.parse(
        '{'\
          '"email": "test@example.com",'\
          '"event": "processed",'\
          '"created": 1431624000,'\
          '"category": ["my_category"],'\
          '"smtp_id": "filter001-2348927389",'\
          '"asm_group_id": null,'\
          '"msg_id": "xxx-abc-123",'\
          '"ip": null,'\
          '"url": null'\
        '}'\
      )
    end

    it '#get_email_activities' do
      allow(client).to receive(:execute).and_return(activities)
      actual = client.get_email_activities
      expect(actual).to be_a(Array)
      actual.each do |activity|
        expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
      end
    end

    it 'creates activity instance' do
      actual = SendGrid4r::REST::EmailActivity.create_activity(activity)
      expect(actual).to be_a(SendGrid4r::REST::EmailActivity::Activity)
      expect(actual.email).to eq('test@example.com')
      expect(actual.event).to eq('processed')
      expect(actual.created).to eq(Time.at(1431624000))
      expect(actual.category).to be_a(Array)
      actual.category.each do |category|
        expect(category).to eq('my_category')
      end
      expect(actual.smtp_id).to eq('filter001-2348927389')
      expect(actual.asm_group_id).to eq(nil)
      expect(actual.msg_id).to eq('xxx-abc-123')
      expect(actual.ip).to eq(nil)
      expect(actual.url).to eq(nil)
    end

    it 'creates activities instance' do
      actual = SendGrid4r::REST::EmailActivity.create_activities(activities)
      expect(actual).to be_a(Array)
      actual.each do |activity|
        expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
      end
    end
  end
end
