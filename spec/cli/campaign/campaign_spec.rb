# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::CLI::Campaign
  describe Campaign do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--title', 'cli_campaign',
          '--subject', 'cli_subject',
          '--sender-id', 493,
          '--list-ids', 402704,
          '--segment-ids', 147305,
          '--categories', 'CAT1',
          '--suppression-group-id', 3581,
          '--html-content',
          '<p>This is HTML</p><a href="[unsubscribe]">here</a>',
          '--plain-content', 'This is PLAIN [unsubscribe]'
        ]
        Campaign.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        Campaign.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317633
        ]
        Campaign.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317707,
          '--title', 'cli_campaign',
          '--subject', 'cli_subject',
          '--sender-id', 493,
          '--list-ids', 405165,
          '--categories', 'CAT1',
          '--suppression-group-id', 3581,
          '--html-content',
          '<p>This is HTML</p><a href="[unsubscribe]">here</a>',
          '--plain-content', 'This is PLAIN [unsubscribe]'
        ]
        Campaign.start(args)
      end

      it '#send' do
        args = [
          'send',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317707
        ]
        Campaign.start(args)
      end

      it '#schedule' do
        args = [
          'schedule',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317769,
          '--send-at', Time.now.to_i + 1800
        ]
        Campaign.start(args)
      end

      it '#reschedule' do
        args = [
          'reschedule',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317735,
          '--send-at', Time.now.to_i
        ]
        Campaign.start(args)
      end

      it '#unschedule' do
        args = [
          'unschedule',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317769
        ]
        Campaign.start(args)
      end

      it '#time' do
        args = [
          'time',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317769
        ]
        Campaign.start(args)
      end

      it '#test' do
        args = [
          'test',
          '--api-key', ENV['API_KEY'],
          '--campaign-id', 317769,
          '--to', 'awwa500@gmail.com'
        ]
        Campaign.start(args)
      end

      it '#sender subcommand' do
        args = [
          'sender'
        ]
        Campaign.start(args)
      end

      it '#contact subcommand' do
        args = [
          'contact'
        ]
        Campaign.start(args)
      end
    end
  end
end
