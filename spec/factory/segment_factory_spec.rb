# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe SegmentFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      let(:condition) do
        ConditionFactory.new.create(
          field: 'last_name',
          value: 'Miller',
          operator: 'eq',
          and_or: ''
        )
      end

      it 'create with mandatory parameters' do
        segment = SegmentFactory.new.create(conditions: [condition])
        expect(segment).to eq(conditions: [condition])
      end

      it 'create with full parameters' do
        segment = SegmentFactory.new.create(
          name: 'Last Name Miller', conditions: [condition]
        )
        expect(segment).to eq(
          name: 'Last Name Miller', conditions: [condition]
        )
      end
    end
  end
end
