# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Categories

      Category = Struct.new(:category)

      def self.create_category(resp)
        Category.new(
          resp["category"]
        )
      end

      module Categories

        include SendGrid4r::REST::Request

        def get_categories(category = nil, limit = nil, offset = nil)
          params = Hash.new
          params["category"] = category if !category.nil?
          params["limit"] = limit if !limit.nil?
          params["offset"] = offset if !limit.nil?
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/categories", params)
          categories = Array.new
          resp_a.each{|resp|
            categories.push(SendGrid4r::REST::Categories::create_category(resp))
          }
          categories
        end

      end
    end
  end
end
