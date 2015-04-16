# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Stats
      #
      # SendGrid Web API v3 Stats - Category
      #
      module Category
        def get_categories_stats(
            start_date:, end_date: nil, aggregated_by: nil, categories:, &block)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            categories: categories
          }
          resp_a = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/categories/stats",
            params,
            &block
          )
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_categories_stats_sums(
            start_date:, end_date: nil, sort_by_metric: nil,
            sort_by_direction: nil, limit: nil, offset: nil, &block)
          params = {
            start_date: start_date,
            end_date: end_date,
            sort_by_metric: sort_by_metric,
            sort_by_direction: sort_by_direction,
            limit: limit,
            offset: offset
          }
          resp = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/categories/stats/sums",
            params,
            &block)
          SendGrid4r::REST::Stats.create_top_stat(resp)
        end
      end
    end
  end
end
