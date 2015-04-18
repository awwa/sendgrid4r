# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Contacts::Segments' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
    @name1 = 'test_segment1'
    @name2 = 'test_segment2'
    @edit_name1 = 'test_segment_edit'
    @field = 'last_name1'
    @value = 'Miller'
    @operator = 'eq'
    @and_or = ''
    @condition_factory = SendGrid4r::Factory::ConditionFactory.new
    @segment_factory = SendGrid4r::Factory::SegmentFactory.new
  end

  context 'without block call' do
    before :all do
      begin
        # celan up test env(segment)
        @client.get_segments.segments.each do |segment|
          @client.delete_segment(segment.id) if segment.name == @name1
          @client.delete_segment(segment.id) if segment.name == @edit_name1
          @client.delete_segment(segment.id) if segment.name == @name2
        end
        # clean up test env(custom_fields)
        @client.get_custom_fields.custom_fields.each do |field|
          @client.delete_custom_field(field.id) if field.name == @field
        end
        # post a custom field and a segment
        @client.post_custom_field(@field, 'text')
        @condition = @condition_factory.create(
          field: @field, value: @value, operator: @operator, and_or: @and_or
        )
        params1 = @segment_factory.create(
          name: @name1, conditions: [@condition]
        )
        @segment1 = @client.post_segment(params1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_segment' do
      begin
        params2 = @segment_factory.create(
          name: @name2, conditions: [@condition]
        )
        segment = @client.post_segment(params2)
        expect(segment.id).to be_a(Fixnum)
        expect(segment.name).to eq(@name2)
        expect(segment.list_id).to eq(nil)
        expect(segment.conditions.length).to eq(1)
        expect(segment.recipient_count).to eq(0)
        condition = segment.conditions[0]
        expect(condition.field).to eq(@field)
        expect(condition.value).to eq(@value)
        expect(condition.operator).to eq(@operator)
        expect(condition.and_or).to eq(nil)
        expect(segment.recipient_count).to eq(0)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_segment' do
      begin
        segment = @client.get_segment(@segment1.id)
        expect(segment.id).to eq(@segment1.id)
        expect(segment.name).to eq(@segment1.name)
        expect(segment.list_id).to eq(nil)
        condition = segment.conditions[0]
        expect(condition.field).to eq(@field)
        expect(condition.value).to eq(@value)
        expect(condition.operator).to eq(@operator)
        expect(condition.and_or).to eq(nil)
        expect(segment.recipient_count).to be_a(Fixnum)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#put_segment' do
      begin
        edit_params = @segment_factory.create(
          name: @edit_name1, conditions: [@condition]
        )
        edit_segment = @client.put_segment(@segment1.id, edit_params)
        expect(edit_segment.name).to eq(@edit_name1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#get_recipients_from_segment' do
      begin
        # list recipients from a single segment
        recipients = @client.get_recipients_from_segment(@segment1.id)
        recipients.recipients.each do |recipient|
          expect(
            recipient
          ).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipient)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#delete_segment' do
      begin
        # delete the segment
        @client.delete_segment(@segment1.id)
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block all' do
    before :all do
      begin
        # celan up test env(segment)
        @client.get_segments.segments.each do |segment|
          @client.delete_segment(segment.id) if segment.name == @name1
          @client.delete_segment(segment.id) if segment.name == @edit_name1
          @client.delete_segment(segment.id) if segment.name == @name2
        end
        # clean up test env(custom_fields)
        @client.get_custom_fields.custom_fields.each do |field|
          @client.delete_custom_field(field.id) if field.name == @field
        end
        # post a custom field and a segment
        @client.post_custom_field(@field, 'text')
        @condition = @condition_factory.create(
          field: @field, value: @value, operator: @operator, and_or: @and_or
        )
        params1 = @segment_factory.create(
          name: @name1, conditions: [@condition]
        )
        @segment1 = @client.post_segment(params1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it '#post_segment' do
      params2 = @segment_factory.create(
        name: @name2, conditions: [@condition]
      )
      @client.post_segment(params2) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Segments.create_segment(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPCreated)
      end
    end

    it '#get_segment' do
      @client.get_segment(@segment1.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Segments.create_segment(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#put_segment' do
      edit_params = @segment_factory.create(
        name: @edit_name1, conditions: [@condition]
      )
      @client.put_segment(@segment1.id, edit_params) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Segments.create_segment(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#get_recipients_from_segment' do
      @client.get_recipients_from_segment(@segment1.id) do |resp, req, res|
        resp =
          SendGrid4r::REST::Contacts::Recipients.create_recipients(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end

    it '#delete_segment' do
      @client.delete_segment(@segment1.id) do |resp, req, res|
        expect(resp).to eq('')
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPNoContent)
      end
    end
  end

  context 'unit test' do
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
      expect(actual.conditions).to be_a(Array)
      actual.conditions.each do |condition|
        expect(condition).to be_a(
          SendGrid4r::REST::Contacts::Segments::Condition
        )
      end
      expect(actual.recipient_count).to be_a(Fixnum)
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
      expect(actual.segments).to be_a(Array)
      actual.segments.each do |segment|
        expect(segment).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
      end
    end
  end
end
