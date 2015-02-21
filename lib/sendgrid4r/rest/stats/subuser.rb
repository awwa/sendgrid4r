# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Stats
      #
      # SendGrid Web API v3 Stats - Subuser
      #
      module Subuser
        def get_subusers_stats(
            start_date:, end_date: nil, aggregated_by: nil, subusers:)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            subusers: subusers
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/subusers/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_subusers_stats_sums(
            start_date:, end_date: nil, sort_by_metric: nil,
            sort_by_direction: nil, limit: nil, offset: nil)
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
            "#{SendGrid4r::Client::BASE_URL}/subusers/stats/sums",
            params
          )
          SendGrid4r::REST::Stats.create_top_stat(resp)
        end
      end
    end
  end
end
