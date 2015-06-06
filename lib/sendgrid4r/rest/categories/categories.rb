# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Categories
      #
      # SendGrid Web API v3 Categories - Categories
      #
      module Categories
        include SendGrid4r::REST::Request

        Category = Struct.new(:category)

        def self.create_category(resp)
          return resp if resp.nil?
          Category.new(resp['category'])
        end

        def self.create_categories(resp)
          return resp if resp.nil?
          categories = []
          resp.each do |category|
            categories.push(
              SendGrid4r::REST::Categories::Categories.create_category(
                category
              )
            )
          end
          categories
        end

        def get_categories(category: nil, limit: nil, offset: nil, &block)
          params = {}
          params['category'] = category unless category.nil?
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless limit.nil?
          resp = get(@auth, "#{BASE_URL}/categories", params, &block)
          SendGrid4r::REST::Categories::Categories.create_categories(resp)
        end
      end
    end
  end
end
