# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Alerts do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])

        # clean up test env
        alerts = @client.get_alerts
        alerts.each do |alert|
          @client.delete_alert(alert_id: alert.id)
        end

        # post a alert
        @alert_usage = @client.post_alert(
          type: :usage_limit, percentage: 66, email_to: ENV['MAIL']
        )
        @alert_stats = @client.post_alert(
          type: :stats_notification, frequency: :daily, email_to: ENV['MAIL']
        )
      end

      context 'without block call' do
        it '#get_alerts' do
          alerts = @client.get_alerts
          expect(alerts).to be_a(Array)
          alerts.each { |alert| expect(alert).to be_a(Alerts::Alert) }
        end

        it '#post_alert :usage_limit' do
          alert = @client.post_alert(
            type: :usage_limit,
            email_to: ENV['MAIL'],
            percentage: 66
          )
          expect(alert).to be_a(Alerts::Alert)
        end

        it '#post_alert :stats_notification' do
          alert = @client.post_alert(
            type: :stats_notification,
            email_to: ENV['MAIL'],
            frequency: :daily
          )
          expect(alert).to be_a(Alerts::Alert)
        end

        it '#get_alert' do
          alert_usage = @client.get_alert(alert_id: @alert_usage.id)
          expect(alert_usage).to be_a(Alerts::Alert)
        end

        it '#delete_alert' do
          @client.delete_alert(
            alert_id: @alert_stats.id
          )
        end

        it '#patch_alert' do
          alert = @client.patch_alert(
            alert_id: @alert_stats.id,
            frequency: :weekly,
            email_to: ENV['MAIL']
          )
          expect(alert).to be_a(Alerts::Alert)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:alerts) do
        '['\
          '{'\
            '"created_at": 1451498784,'\
            '"email_to": "test@example.com",'\
            '"id": 46,'\
            '"percentage": 90,'\
            '"type": "usage_limit",'\
            '"updated_at": 1451498784'\
          '},'\
          '{'\
            '"created_at": 1451498812,'\
            '"email_to": "test@example.com",'\
            '"frequency": "monthly",'\
            '"id": 47,'\
            '"type": "stats_notification",'\
            '"updated_at": 1451498812'\
          '},'\
          '{'\
            '"created_at": 1451520930,'\
            '"email_to": "test@example.com",'\
            '"frequency": "daily",'\
            '"id": 48,'\
            '"type": "stats_notification",'\
            '"updated_at": 1451520930'\
          '}'\
        ']'
      end

      let(:alert) do
        '{'\
          '"created_at": 1451520930,'\
          '"email_to": "test@example.com",'\
          '"frequency": "daily",'\
          '"id": 48,'\
          '"type": "stats_notification",'\
          '"updated_at": 1451520930'\
        '}'
      end

      it '#get_alerts' do
        allow(client).to receive(:execute).and_return(alerts)
        actual = client.get_alerts
        expect(actual).to be_a(Array)
        actual.each { |alert| expect(alert).to be_a(Alerts::Alert) }
      end

      it '#post_alert' do
        allow(client).to receive(:execute).and_return(alert)
        actual = client.post_alert(
          type: :usage_limit, email_to: '', percentage: 66
        )
        expect(actual).to be_a(Alerts::Alert)
      end

      it '#get_alert' do
        allow(client).to receive(:execute).and_return(alert)
        actual = client.get_alert(alert_id: 0)
        expect(actual).to be_a(Alerts::Alert)
      end

      it '#delete_alert' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_alert(alert_id: 0)
        expect(actual).to eq('')
      end

      it '#patch_alert' do
        allow(client).to receive(:execute).and_return(alert)
        actual = client.patch_alert(
          alert_id: 0, frequency: :weekly, email_to: ''
        )
        expect(actual).to be_a(Alerts::Alert)
      end

      it 'creates alerts instance' do
        actual = Alerts.create_alerts(JSON.parse(alerts))
        expect(actual).to be_a(Array)
        expect(actual[0].created_at).to eq(Time.at(1451498784))
        expect(actual[0].email_to).to eq('test@example.com')
        expect(actual[0].id).to eq(46)
        expect(actual[0].percentage).to eq(90)
        expect(actual[0].type).to eq('usage_limit')
        expect(actual[0].updated_at).to eq(Time.at(1451498784))
        expect(actual[1].created_at).to eq(Time.at(1451498812))
        expect(actual[1].email_to).to eq('test@example.com')
        expect(actual[1].frequency).to eq('monthly')
        expect(actual[1].id).to eq(47)
        expect(actual[1].type).to eq('stats_notification')
        expect(actual[1].updated_at).to eq(Time.at(1451498812))
        expect(actual[2].created_at).to eq(Time.at(1451520930))
        expect(actual[2].email_to).to eq('test@example.com')
        expect(actual[2].frequency).to eq('daily')
        expect(actual[2].id).to eq(48)
        expect(actual[2].type).to eq('stats_notification')
        expect(actual[2].updated_at).to eq(Time.at(1451520930))
      end

      it 'creates alert instance' do
        actual = Alerts.create_alert(JSON.parse(alert))
        expect(actual).to be_a(Alerts::Alert)
        expect(actual.created_at).to eq(Time.at(1451520930))
        expect(actual.email_to).to eq('test@example.com')
        expect(actual.frequency).to eq('daily')
        expect(actual.id).to eq(48)
        expect(actual.type).to eq('stats_notification')
        expect(actual.updated_at).to eq(Time.at(1451520930))
      end
    end
  end
end
