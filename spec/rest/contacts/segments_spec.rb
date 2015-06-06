# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

describe SendGrid4r::REST::Contacts::Segments do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
        @name1 = 'test_segment1'
        @name2 = 'test_segment2'
        @edit_name1 = 'test_segment_edit'
        @field = 'last_name1'
        @value = 'Miller'
        @operator = 'eq'
        @and_or = ''
        @condition_factory = SendGrid4r::Factory::ConditionFactory.new
        @segment_factory = SendGrid4r::Factory::SegmentFactory.new

        # celan up test env(segment)
        @client.get_segments.segments.each do |segment|
          @client.delete_segment(
            segment_id: segment.id
          ) if segment.name == @name1
          @client.delete_segment(
            segment_id: segment.id
          ) if segment.name == @edit_name1
          @client.delete_segment(
            segment_id: segment.id
          ) if segment.name == @name2
        end
        # clean up test env(custom_fields)
        @client.get_custom_fields.custom_fields.each do |field|
          @client.delete_custom_field(
            custom_field_id: field.id
          ) if field.name == @field
        end
        # post a custom field and a segment
        @client.post_custom_field(name: @field, type: 'text')
        @condition = @condition_factory.create(
          field: @field, value: @value, operator: @operator, and_or: @and_or
        )
        params1 = @segment_factory.create(
          name: @name1, conditions: [@condition]
        )
        @segment1 = @client.post_segment(params: params1)
      rescue => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#post_segment' do
        begin
          params2 = @segment_factory.create(
            name: @name2, conditions: [@condition]
          )
          segment = @client.post_segment(params: params2)
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

      it '#get_segments' do
        begin
          segments = @client.get_segments
          segments.segments.each do |segment|
            expect(
              segment
            ).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
          end
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_segment' do
        begin
          segment = @client.get_segment(segment_id: @segment1.id)
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
          pending 'waiting for sendgrid documentation update'
          edit_params = @segment_factory.create(
            name: @edit_name1, conditions: [@condition]
          )
          edit_segment = @client.put_segment(
            segment_id: @segment1.id, params: edit_params
          )
          expect(edit_segment.name).to eq(@edit_name1)
        rescue => e
          puts e.inspect
          raise e
        end
      end

      it '#get_recipients_from_segment' do
        begin
          # list recipients from a single segment
          recipients = @client.get_recipients_from_segment(
            segment_id: @segment1.id
          )
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
          @client.delete_segment(segment_id: @segment1.id)
        rescue => e
          puts e.inspect
          raise e
        end
      end
    end

    context 'with block all' do
      it '#post_segment' do
        params2 = @segment_factory.create(
          name: @name2, conditions: [@condition]
        )
        @client.post_segment(params: params2) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Segments.create_segment(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPCreated)
        end
      end

      it '#get_segments' do
        @client.get_segments do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Segments.create_segments(
              JSON.parse(resp)
            )
          expect(resp).to be_a(SendGrid4r::REST::Contacts::Segments::Segments)
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#get_segment' do
        @client.get_segment(segment_id: @segment1.id) do |resp, req, res|
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
        pending 'waiting for sendgrid documentation update'
        edit_params = @segment_factory.create(
          name: @edit_name1, conditions: [@condition]
        )
        @client.put_segment(
          segment_id: @segment1.id, params: edit_params
        ) do |resp, req, res|
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
        @client.get_recipients_from_segment(
          segment_id: @segment1.id
        ) do |resp, req, res|
          resp =
            SendGrid4r::REST::Contacts::Recipients.create_recipients(
              JSON.parse(resp)
            )
          expect(resp).to be_a(
            SendGrid4r::REST::Contacts::Recipients::Recipients
          )
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPOK)
        end
      end

      it '#delete_segment' do
        @client.delete_segment(segment_id: @segment1.id) do |resp, req, res|
          expect(resp).to eq('')
          expect(req).to be_a(RestClient::Request)
          expect(res).to be_a(Net::HTTPNoContent)
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:condition) do
      JSON.parse(
        '{'\
          '"field": "last_name",'\
          '"value": "Miller",'\
          '"operator": "eq",'\
          '"and_or": ""'\
        '}'
      )
    end

    let(:segment) do
      JSON.parse(
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
      )
    end

    let(:segments) do
      JSON.parse(
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
      )
    end

    let(:recipients) do
      JSON.parse(
        '{'\
          '"recipients": ['\
            '{'\
              '"created_at": 1422313607,'\
              '"email": "jones@example.com",'\
              '"first_name": null,'\
              '"id": "jones@example.com",'\
              '"last_clicked": null,'\
              '"last_emailed": null,'\
              '"last_name": "Jones",'\
              '"last_opened": null,'\
              '"updated_at": 1422313790,'\
              '"custom_fields": ['\
                '{'\
                  '"id": 23,'\
                  '"name": "pet",'\
                  '"value": "Fluffy",'\
                  '"type": "text"'\
                '}'\
              ']'\
            '}'\
          ']'\
        '}'
      )
    end

    it '#post_segment' do
      allow(client).to receive(:execute).and_return(segment)
      actual = client.post_segment(params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
    end

    it '#get_segments' do
      allow(client).to receive(:execute).and_return(segments)
      actual = client.get_segments
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segments)
    end

    it '#get_segment' do
      allow(client).to receive(:execute).and_return(segment)
      actual = client.get_segment(segment_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
    end

    it '#put_segment' do
      allow(client).to receive(:execute).and_return(segment)
      actual = client.put_segment(segment_id: 0, params: nil)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
    end

    it '#get_recipients_from_segment' do
      allow(client).to receive(:execute).and_return(recipients)
      actual = client.get_recipients_from_segment(segment_id: 0)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Recipients::Recipients)
    end

    it '#delete_segment' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_segment(segment_id: 0)
      expect(actual).to eq('')
    end

    it 'creates condition instance' do
      actual = SendGrid4r::REST::Contacts::Segments.create_condition(condition)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Condition)
      expect(actual.field).to eq('last_name')
      expect(actual.value).to eq('Miller')
      expect(actual.operator).to eq('eq')
      expect(actual.and_or).to eq('')
    end

    it 'creates segment instance' do
      actual = SendGrid4r::REST::Contacts::Segments.create_segment(segment)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
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
      actual = SendGrid4r::REST::Contacts::Segments.create_segments(segments)
      expect(actual).to be_a(SendGrid4r::REST::Contacts::Segments::Segments)
      expect(actual.segments).to be_a(Array)
      actual.segments.each do |segment|
        expect(segment).to be_a(SendGrid4r::REST::Contacts::Segments::Segment)
      end
    end
  end
end
