# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::Factory::SegmentFactory do
  before :all do
    Dotenv.load
    @segment_factory = SendGrid4r::Factory::SegmentFactory.new
    @condition_factory = SendGrid4r::Factory::ConditionFactory.new
    @condition = @condition_factory.create(
      field: 'last_name',
      value: 'Miller',
      operator: 'eq',
      and_or: '')
    @expect = {}
    @expect[:id] = nil
    @expect[:name] = 'Last Name Miller'
    @expect[:list_id] = nil
    @expect[:conditions] = [@condition]
    @expect[:recipient_count] = nil
  end

  context 'always' do
    it 'is full params case' do
      segment = @segment_factory.create(
        name: 'Last Name Miller', conditions: [@condition]
      )
      expect(segment).to eq(@expect)
    end
  end
end
