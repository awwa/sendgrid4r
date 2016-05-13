# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe ConditionFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
        @factory = ConditionFactory.new
        @expect = {}
        @expect[:field] = 'last_name'
        @expect[:value] = 'Miller'
        @expect[:operator] = 'eq'
        @expect[:and_or] = ''
      end

      it 'specify all params' do
        condition = @factory.create(
          field: 'last_name',
          value: 'Miller',
          operator: 'eq',
          and_or: '')
        expect(condition).to eq(@expect)
      end
    end
  end
end
