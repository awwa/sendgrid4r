# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::CLI::Campaign::Contact
  describe Segment do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#create without and_or' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--name', 'cli_segment1',
          '--list-id', 402704,
          '--conditions', 'field:email,value:abc@abc.abc,operator:eq'
        ]
        Segment.start(args)
      end

      it '#create with nil and_or' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--name', 'cli_segment2',
          '--list-id', 402704,
          '--conditions', 'field:email,value:abc@abc.abc,operator:eq,and_or:'
        ]
        Segment.start(args)
      end

      it '#create with multiple conditions' do
        args = [
          'create',
          '--api-key', ENV['API_KEY'],
          '--name', 'cli_segment3',
          '--list-id', 402704,
          '--conditions',
          'field:email,value:abc@abc.abc,operator:eq,and_or:',
          'field:email,value:abc@abc.abc,operator:eq,and_or:and'
        ]
        Segment.start(args)
      end

      it '#list' do
        args = [
          'list',
          '--api-key', ENV['API_KEY']
        ]
        Segment.start(args)
      end

      it '#get' do
        args = [
          'get',
          '--api-key', ENV['API_KEY'],
          '--segment-id', 208991
        ]
        Segment.start(args)
      end

      it '#update' do
        args = [
          'update',
          '--api-key', ENV['API_KEY'],
          '--segment-id', 208991,
          '--name', 'cli_segment_edit',
          '--conditions', 'field:email,value:abc@abc.abc,operator:eq,and_or:'
        ]
        Segment.start(args)
      end

      it '#delete' do
        args = [
          'delete',
          '--api-key', ENV['API_KEY'],
          '--segment-id', 208991
        ]
        Segment.start(args)
      end

      it '#recipient with list action' do
        args = [
          'recipient', 'list',
          '--api-key', ENV['API_KEY'],
          '--segment-id', 208991
        ]
        Segment.start(args)
      end
    end
  end
end
