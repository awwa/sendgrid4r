# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Categories
  #
  module Categories
    include Request

    Category = Struct.new(:category)

    def self.create_category(resp)
      return resp if resp.nil?
      Category.new(resp['category'])
    end

    def self.create_categories(resp)
      return resp if resp.nil?
      resp.map { |category| Categories.create_category(category) }
    end

    def get_categories(category: nil, limit: nil, offset: nil, &block)
      params = {}
      params['category'] = category unless category.nil?
      params['limit'] = limit unless limit.nil?
      params['offset'] = offset unless limit.nil?
      resp = get(@auth, "#{BASE_URL}/categories", params, &block)
      Categories.create_categories(resp)
    end
  end
end
