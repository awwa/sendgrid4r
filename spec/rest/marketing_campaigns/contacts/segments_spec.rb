# encoding: utf-8
require File.dirname(__FILE__) + '/../../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns::Contacts
  describe Segments do
    describe 'integration test', :it do
      before do
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
          name: @name1, list_id: nil, conditions: [@condition]
        )
        @segment1 = @client.post_segment(params: params1)
      end

      context 'without block call' do
        it '#post_segment' do
          lists = @client.get_lists
          params2 = @segment_factory.create(
            name: @name2, list_id: lists.lists[0].id, conditions: [@condition]
          )
          segment = @client.post_segment(params: params2)
          expect(segment.id).to be_a(Fixnum)
          expect(segment.name).to eq(@name2)
          expect(segment.list_id).to eq(lists.lists[0].id)
          expect(segment.conditions.length).to eq(1)
          expect(segment.recipient_count).to eq(0)
          condition = segment.conditions[0]
          expect(condition.field).to eq(@field)
          expect(condition.value).to eq(@value)
          expect(condition.operator).to eq(@operator)
          expect(condition.and_or).to eq(nil)
          expect(segment.recipient_count).to eq(0)
        end

        it '#get_segments' do
          segments = @client.get_segments
          segments.segments.each do |segment|
            expect(segment).to be_a(Segments::Segment)
          end
        end

        it '#get_segment' do
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
        end

        it '#patch_segment' do
          edit_params = @segment_factory.create(
            name: @edit_name1, conditions: [@condition]
          )
          edit_segment = @client.patch_segment(
            segment_id: @segment1.id, params: edit_params
          )
          expect(edit_segment.name).to eq(@edit_name1)
        end

        it '#delete_segment' do
          @client.delete_segment(segment_id: @segment1.id)
        end

        it '#get_recipients_on_segment' do
          recipients = @client.get_recipients_on_segment(
            segment_id: @segment1.id
          )
          recipients.recipients.each do |recipient|
            expect(recipient).to be_a(Recipients::Recipient)
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
            '"list_id": 4,'\
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
                '"list_id": 4,'\
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
        expect(actual).to be_a(Segments::Segment)
      end

      it '#get_segments' do
        allow(client).to receive(:execute).and_return(segments)
        actual = client.get_segments
        expect(actual).to be_a(Segments::Segments)
      end

      it '#get_segment' do
        allow(client).to receive(:execute).and_return(segment)
        actual = client.get_segment(segment_id: 0)
        expect(actual).to be_a(Segments::Segment)
      end

      it '#patch_segment' do
        allow(client).to receive(:execute).and_return(segment)
        actual = client.patch_segment(segment_id: 0, params: nil)
        expect(actual).to be_a(Segments::Segment)
      end

      it '#get_recipients_on_segment' do
        allow(client).to receive(:execute).and_return(recipients)
        actual = client.get_recipients_on_segment(segment_id: 0)
        expect(actual).to be_a(Recipients::Recipients)
      end

      it '#delete_segment' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_segment(segment_id: 0)
        expect(actual).to eq('')
      end

      it 'creates condition instance' do
        actual = Segments.create_condition(condition)
        expect(actual).to be_a(Segments::Condition)
        expect(actual.field).to eq('last_name')
        expect(actual.value).to eq('Miller')
        expect(actual.operator).to eq('eq')
        expect(actual.and_or).to eq('')
      end

      it 'creates segment instance' do
        actual = Segments.create_segment(segment)
        expect(actual).to be_a(Segments::Segment)
        expect(actual.id).to eq(1)
        expect(actual.name).to eq('Last Name Miller')
        expect(actual.list_id).to eq(4)
        expect(actual.conditions).to be_a(Array)
        actual.conditions.each do |condition|
          expect(condition).to be_a(Segments::Condition)
        end
        expect(actual.recipient_count).to be_a(Fixnum)
      end

      it 'creates segments instance' do
        actual = Segments.create_segments(segments)
        expect(actual).to be_a(Segments::Segments)
        expect(actual.segments).to be_a(Array)
        actual.segments.each do |segment|
          expect(segment).to be_a(Segments::Segment)
        end
      end
    end
  end
end
