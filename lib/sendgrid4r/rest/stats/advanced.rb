# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Stats
      #
      # SendGrid Web API v3 Stats - Advanced
      #
      module Advanced
        def get_geo_stats(
            start_date:, end_date: nil, aggregated_by: nil, country: nil)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            country: country
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/geo/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_devices_stats(start_date:, end_date: nil, aggregated_by: nil)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/devices/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_clients_stats(start_date:, end_date: nil, aggregated_by: nil)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/clients/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_clients_type_stats(
            start_date:, end_date: nil, aggregated_by: nil, client_type:)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            client_type: client_type
          }
          resp_a = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/clients/#{client_type}/stats",
            params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_esp_stats(
            start_date:, end_date: nil, aggregated_by: nil, esps: nil)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            esps: esps
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/esp/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end

        def get_browsers_stats(
            start_date:, end_date: nil, aggregated_by: nil, browsers: nil)
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            browsers: browsers
          }
          resp_a = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/browsers/stats", params)
          SendGrid4r::REST::Stats.create_top_stats(resp_a)
        end
      end
    end
  end
end
