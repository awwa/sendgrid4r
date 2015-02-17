# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Stats
      module Global
        def get_global_stats(start_date, end_date = nil, aggregated_by = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
      end
    end
  end
end
