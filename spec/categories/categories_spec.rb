# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe "SendGrid4r::REST::Categories" do

  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
  end

  context "always" do
    it "is normal when nothing specified" do
      categories = @client.get_categories
      expect(true).to eq(categories.is_a?(Array))
      expect(categories.length >= 0).to eq(true)
      categories.each{|category|
        expect(category.category.length > 0).to eq(true)
      }
    end

    it "is normal when specify category" do
      categories = @client.get_categories("Newsletter", nil, nil)
      expect(true).to eq(categories.is_a?(Array))
      expect(categories.length).to eq(1)
      categories.each{|category|
        expect(category.category).to eq("Newsletter")
      }
    end

    it "returns is normal" do
      categories = @client.get_categories(nil, 5, 2)
      expect(true).to eq(categories.is_a?(Array))
      expect(categories.length).to eq(5)
      categories.each{|category|
        expect(category.category.length > 0).to eq(true)
      }
    end
  end

end
