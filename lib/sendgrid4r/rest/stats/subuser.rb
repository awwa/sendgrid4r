# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Stats
    #
    # SendGrid Web API v3 Stats - Subuser
    #
    module Subuser
      include Request

      def self.url(subuser_name = nil, aggregate = nil)
        url = "#{BASE_URL}/subusers"
        if subuser_name.nil?
          url = "#{url}/stats"
        else
          url = "#{url}/#{subuser_name}/stats"
        end
        url = "#{url}/#{aggregate}" unless aggregate.nil?
        url
      end

      def get_subusers_stats(
          start_date:, end_date: nil, aggregated_by: nil, subusers:, &block)
        params = {
          start_date: start_date,
          end_date: end_date,
          aggregated_by: aggregated_by,
          subusers: subusers
        }
        resp = get(@auth, Subuser.url, params, &block)
        finish(resp, @raw_resp) { |r| Stats.create_top_stats(r) }
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
        resp = get(@auth, Subuser.url(nil, :sums), params, &block)
        finish(resp, @raw_resp) { |r| Stats.create_top_stat(r) }
      end

      def get_subusers_stats_monthly(
          date:, subuser: nil, sort_by_metric: nil, sort_by_direction: nil,
          limit: nil, offset: nil, &block)
        params = {
          date: date,
          subuser: subuser,
          sort_by_metric: sort_by_metric,
          sort_by_direction: sort_by_direction,
          limit: limit,
          offset: offset
        }
        resp = get(@auth, Subuser.url(nil, :monthly), params, &block)
        finish(resp, @raw_resp) { |r| Stats.create_top_stat(r) }
      end

      def get_subuser_stats_monthly(
          subuser_name:, date:, sort_by_metric: nil, sort_by_direction: nil,
          limit: nil, offset: nil, &block)
        params = {
          date: date,
          sort_by_metric: sort_by_metric,
          sort_by_direction: sort_by_direction,
          limit: limit,
          offset: offset
        }
        resp = get(@auth, Subuser.url(subuser_name, :monthly), params, &block)
        finish(resp, @raw_resp) { |r| Stats.create_top_stat(r) }
      end
    end
  end
end
