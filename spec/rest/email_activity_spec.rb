# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::EmailActivity do
  describe 'integration test', :it do
    before do
      Dotenv.load
      @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
    end

    context 'without block call' do
      it '#get_email_activities' do
        activities = @client.get_email_activities
        activities.each do |activity|
          expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
        end
      end

      it '#get_email_activities with email' do
        activities = @client.get_email_activities(email: 'test@test.com')
        activities.each do |activity|
          expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
        end
      end

      it '#get_email_activities with events' do
        activities = @client.get_email_activities(
          events: [SendGrid4r::Client::Event::DROPS]
        )
        expect(activities.length).to be >= 0
        activities.each do |activity|
          expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
          expect(activity.event).to eq('drop')
        end
      end

      it '#get_email_activities with multiple events' do
        events = []
        events.push(SendGrid4r::Client::Event::DROPS)
        events.push(SendGrid4r::Client::Event::DELIVERED)
        events.push(SendGrid4r::Client::Event::BOUNCES)
        events.push(SendGrid4r::Client::Event::CLICKS)
        events.push(SendGrid4r::Client::Event::DEFERRED)
        events.push(SendGrid4r::Client::Event::DELIVERED)
        events.push(SendGrid4r::Client::Event::DROPS)
        events.push(SendGrid4r::Client::Event::GROUP_UNSUBSCRIBE)
        events.push(SendGrid4r::Client::Event::GROUP_RESUBSCRIBE)
        events.push(SendGrid4r::Client::Event::OPENS)
        events.push(SendGrid4r::Client::Event::PROCESSED)
        events.push(SendGrid4r::Client::Event::PARSEAPI)
        events.push(SendGrid4r::Client::Event::SPAM_REPORTS)
        events.push(SendGrid4r::Client::Event::UNSUBSCRIBE)
        activities = @client.get_email_activities(events: events)
        expect(activities.length).to be >= 0
        activities.each do |activity|
          expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
        end
      end

      it '#get_email_activities with start_time and end_time' do
        pending('unknown field')
        start_time = Time.local(2015, 5, 20, 12, 23, 45)
        end_time = Time.local(2015, 5, 23, 12, 23, 45)
        activities = @client.get_email_activities(
          start_time: start_time, end_time: end_time
        )
        expect(activities.length).to be >= 0
        activities.each do |activity|
          expect(activity).to be_a(SendGrid4r::REST::EmailActivity::Activity)
          puts activity.inspect
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
