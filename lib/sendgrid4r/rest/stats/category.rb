# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Stats
      module Category
        def get_categories_stats(categories, start_date, end_date = nil, aggregated_by = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          #params["categories"] = Array(categories) if !categories.nil?
          params["categories"] = categories if !categories.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/categories/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_categories_stats_sums(start_date, end_date = nil, sort_by_metric = nil, sort_by_direction = nil, limit = nil, offset = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["sort_by_metric"] = sort_by_metric if !sort_by_metric.nil?
          params["soft_by_direction"] = sort_by_direction if !sort_by_direction.nil?
          params["limit"] = limit if !limit.nil?
          params["offset"] = offset if !offset.nil?
          resp = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/categories/stats/sums", params)
          SendGrid4r::REST::Stats::create_top_stat(resp)
        end
      end
    end
  end
end
