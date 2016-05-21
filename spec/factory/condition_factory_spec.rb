# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::Factory
  describe ConditionFactory do
    describe 'unit test', :ut do
      before do
        Dotenv.load
      end

      it 'create with full parameters' do
        condition = ConditionFactory.new.create(
          field: 'last_name',
          value: 'Miller',
          operator: 'eq',
          and_or: '')
        expect(condition).to eq(
          field: 'last_name',
          value: 'Miller',
          operator: 'eq',
          and_or: ''
        )
      end
    end
  end
end
