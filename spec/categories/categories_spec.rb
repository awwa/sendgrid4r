# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Categories' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'])
  end

  context 'without block call' do
    it 'get_categories if no params' do
      begin
        categories = @client.get_categories
        expect(categories.length).to be >= 0
        categories.each do |category|
          expect(category.category).to be_a(String)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'get_categories if name was specified' do
      begin
        categories = @client.get_categories('Newsletter')
        expect(categories.length).to eq(1)
        categories.each do |category|
          expect(category.category).to eq('Newsletter')
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end

    it 'get_categories if offset & limit were specified' do
      begin
        categories = @client.get_categories(nil, 5, 2)
        expect(categories.length).to be > 0
        categories.each do |category|
          expect(category.category).to be_a(String)
        end
      rescue => e
        puts e.inspect
        raise e
      end
    end
  end

  context 'with block call' do
    it 'get_categories' do
      @client.get_categories do |resp, req, res|
        resp =
          SendGrid4r::REST::Categories::Categories.create_categories(
            JSON.parse(resp)
          )
        expect(resp).to be_a(SendGrid4r::REST::Categories::Categories)
        expect(req).to be_a(RestClient::Request)
        expect(res).to be_a(Net::HTTPOK)
      end
    end
  end

  context 'unit test' do
    it 'creates categories instance' do
      json =
        '['\
          '{"category": "cat1"},'\
          '{"category": "cat2"},'\
          '{"category": "cat3"},'\
          '{"category": "cat4"},'\
          '{"category": "cat5"}'\
        ']'
      hash = JSON.parse(json)
      actual = SendGrid4r::REST::Categories::Categories.create_categories(hash)
      expect(actual).to be_a(Array)
      actual.each do |category|
        expect(category).to be_a(
          SendGrid4r::REST::Categories::Categories::Category
        )
      end
    end
  end
end
