# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Stats
      module Advanced
        def get_geo_stats(start_date, end_date = nil, aggregated_by = nil, country = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          params["country"] = country if !country.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/geo/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_devices_stats(start_date, end_date = nil, aggregated_by = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/devices/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_clients_stats(start_date, end_date = nil, aggregated_by = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/clients/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_clients_type_stats(client_type, start_date, end_date = nil, aggregated_by = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/clients/#{client_type}/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_esp_stats(start_date, end_date = nil, aggregated_by = nil, esps = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          params["esps"] = esps if !esps.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/esp/stats", params)
          resp_a.each{|resp|
            top_stats.push(
              SendGrid4r::REST::Stats::create_top_stat(resp))
          }
          top_stats
        end
        def get_browsers_stats(start_date, end_date = nil, aggregated_by = nil, browsers = nil)
          params = Hash.new
          params["start_date"] = start_date if !start_date.nil?
          params["end_date"] = end_date if !end_date.nil?
          params["aggregated_by"] = aggregated_by if !aggregated_by.nil?
          params["browsers"] = browsers if !browsers.nil?
          top_stats = Array.new
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/browsers/stats", params)
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
