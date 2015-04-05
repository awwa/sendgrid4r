# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Segments' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    @name = 'test_segment'
    @edit_name = 'test_segment_edit'
    @field = 'last_name'
    @value = 'Miller'
    @operator = 'eq'
    @and_or = ''
    @condition_factory = SendGrid4r::Factory::ConditionFactory.new
    @segment_factory = SendGrid4r::Factory::SegmentFactory.new
  end

  context 'always' do
    it 'is normal' do
      begin
        # celan up test env
        segments = @client.get_segments
        expect(segments.segments.length >= 0).to eq(true)
        segments.segments.each do |segment|
          next if segment.name != @name && segment.name != @edit_name
          @client.delete_segment(segment.id)
        end
        # post a segment
        condition = @condition_factory.create(
          field: @field,
          value: @value,
          operator: @operator,
          and_or: @and_or
        )
        params = @segment_factory.create(
          name: @name, conditions: [condition]
        )
        new_segment = @client.post_segment(params)
        expect(new_segment.id.is_a?(Fixnum)).to eq(true)
        expect(new_segment.name).to eq(@name)
        expect(new_segment.list_id).to eq(nil)
        expect(new_segment.conditions.length).to eq(1)
        expect(new_segment.recipient_count).to eq(0)
        new_condition = new_segment.conditions[0]
        expect(new_condition.field).to eq(@field)
        expect(new_condition.value).to eq(@value)
        expect(new_condition.operator).to eq(@operator)
        expect(new_condition.and_or).to eq(nil)
        expect(new_segment.recipient_count).to eq(0)
        # get a single segment
        actual_segment = @client.get_segment(new_segment.id)
        expect(actual_segment.id).to eq(new_segment.id)
        expect(actual_segment.name).to eq(new_segment.name)
        expect(actual_segment.list_id).to eq(nil)
        actual_condition = actual_segment.conditions[0]
        expect(actual_condition.field).to eq(@field)
        expect(actual_condition.value).to eq(@value)
        expect(actual_condition.operator).to eq(@operator)
        expect(actual_condition.and_or).to eq(nil)
        expect(actual_segment.recipient_count.is_a?(Fixnum)).to eq(true)
        # update the segment
        edit_condition = @condition_factory.create(
          field: @field,
          value: @value,
          operator: @operator,
          and_or: @and_or
        )
        edit_params = @segment_factory.create(
          name: @edit_name, conditions: [edit_condition]
        )
        edit_segment = @client.put_segment(new_segment.id, edit_params)
        expect(edit_segment.name).to eq(@edit_name)
        # list recipients from a single segment
        recipients = @client.get_recipients_from_segment(new_segment.id)
        recipients.recipients.each do |recipient|
          expect(
            recipient.is_a?(SendGrid4r::REST::Contacts::Recipients::Recipient)
          ).to eq(true)
        end
        # delete the segment
        @client.delete_segment(new_segment.id)
        expect do
          @client.get_segment(new_segment.id)
        end.to raise_error(RestClient::ResourceNotFound)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'creates condition instance' do
      json =
        '{'\
          '"field": "last_name",'\
          '"value": "Miller",'\
          '"operator": "eq",'\
          '"and_or": ""'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Segments.create_condition(hash)
      expect(actual.field).to eq('last_name')
      expect(actual.value).to eq('Miller')
      expect(actual.operator).to eq('eq')
      expect(actual.and_or).to eq('')
    end

    it 'creates segment instance' do
      json =
        '{'\
          '"id": 1,'\
          '"name": "Last Name Miller",'\
          '"list_id": null,'\
          '"conditions": ['\
            '{'\
              '"field": "last_name",'\
              '"value": "Miller",'\
              '"operator": "eq",'\
              '"and_or": ""'\
            '}'\
          '],'\
          '"recipient_count": 1'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Segments.create_segment(hash)
      expect(actual.id).to eq(1)
      expect(actual.name).to eq('Last Name Miller')
      expect(actual.list_id).to eq(nil)
      expect(actual.conditions.is_a?(Array)).to eq(true)
      actual.conditions.each do |condition|
        expect(
          condition.is_a?(
            SendGrid4r::REST::Contacts::Segments::Condition
          )
        ).to eq(true)
      end
      expect(actual.recipient_count).to eq(1)
    end

    it 'creates segments instance' do
      json =
        '{'\
          '"segments": ['\
            '{'\
              '"id": 1,'\
              '"name": "Last Name Miller",'\
              '"list_id": null,'\
              '"conditions": ['\
                '{'\
                  '"field": "last_name",'\
                  '"value": "Miller",'\
                  '"operator": "eq",'\
                  '"and_or": ""'\
                '}'\
              '],'\
              '"recipient_count": 1'\
            '}'\
          ']'\
        '}'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Contacts::Segments.create_segments(hash)
      expect(actual.segments.is_a?(Array)).to eq(true)
      actual.segments.each do |segment|
        expect(
          segment.is_a?(SendGrid4r::REST::Contacts::Segments::Segment)
        ).to eq(true)
      end
    end
  end
end
