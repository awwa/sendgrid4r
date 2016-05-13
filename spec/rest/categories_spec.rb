# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Categories do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
      end

      context 'without block call' do
        it '#get_categories if no params' do
          categories = @client.get_categories
          expect(categories.length).to be >= 0
          categories.each do |category|
            expect(category.category).to be_a(String)
          end
        end

        it '#get_categories if name was specified' do
          categories = @client.get_categories(category: 'Newsletter')
          expect(categories.length).to eq(1)
          categories.each do |category|
            expect(category.category).to eq('Newsletter')
          end
        end

        it '#get_categories if offset & limit were specified' do
          categories = @client.get_categories(
            category: nil, limit: 5, offset: 2
          )
          expect(categories.length).to be > 0
          categories.each do |category|
            expect(category.category).to be_a(String)
          end
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:categories) do
        JSON.parse(
          '['\
            '{"category": "cat1"},'\
            '{"category": "cat2"},'\
            '{"category": "cat3"},'\
            '{"category": "cat4"},'\
            '{"category": "cat5"}'\
          ']'
        )
      end

      it '#get_categories' do
        allow(client).to receive(:execute).and_return(categories)
        actual = client.get_categories
        expect(actual).to be_a(Array)
        actual.each do |category|
          expect(category).to be_a(Categories::Category)
        end
      end

      it 'creates categories instance' do
        actual = Categories.create_categories(categories)
        expect(actual).to be_a(Array)
        actual.each do |category|
          expect(category).to be_a(Categories::Category)
          expect(category.category).to be_a(String)
        end
      end
    end
  end
end
