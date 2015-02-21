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
          Category.new(resp['category'])
        end

        def get_categories(category = nil, limit = nil, offset = nil)
          params = {}
          params['category'] = category unless category.nil?
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless limit.nil?
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/categories", params)
          categories = []
          resp_a.each do |resp|
            categories.push(
              SendGrid4r::REST::Categories::Categories.create_category(resp))
          end
          categories
        end
      end
    end
  end
end
