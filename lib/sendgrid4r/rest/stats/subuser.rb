# -*- encoding: utf-8 -*-


module SendGrid4r
  module REST
    module Stats
      #
      # SendGrid Web API v3 Stats - Subuser
      #
      module Subuser
        include SendGrid4r::REST::Request

        def get_subusers_stats(
            start_date:, end_date: nil, aggregated_by: nil, subusers:, &block)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            subusers: subusers
          }
          resp = get(@auth, "#{BASE_URL}/subusers/stats", params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_subusers_stats_sums(
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
          resp = get(@auth, "#{BASE_URL}/subusers/stats/sums", params, &block)
          SendGrid4r::REST::Stats.create_top_stat(resp)
        end
      end
    end
  end
end
