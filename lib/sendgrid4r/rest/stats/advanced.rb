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
        include SendGrid4r::REST::Request

        def get_geo_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            country: nil,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            country: country
          }
          resp = get(@auth, "#{BASE_URL}/geo/stats", params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_devices_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by
          }
          resp = get(@auth, "#{BASE_URL}/devices/stats", params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_clients_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by
          }
          resp = get(@auth, "#{BASE_URL}/clients/stats", params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_clients_type_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            client_type:,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            client_type: client_type
          }
          endpoint = "#{BASE_URL}/clients/#{client_type}/stats"
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_mailbox_providers_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            esps: nil,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            esps: esps
          }
          endpoint = "#{BASE_URL}/mailbox_providers/stats"
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end

        def get_browsers_stats(
            start_date:,
            end_date: nil,
            aggregated_by: nil,
            browsers: nil,
            &block
          )
          params = {
            start_date: start_date,
            end_date: end_date,
            aggregated_by: aggregated_by,
            browsers: browsers
          }
          resp = get(@auth, "#{BASE_URL}/browsers/stats", params, &block)
          SendGrid4r::REST::Stats.create_top_stats(resp)
        end
      end
    end
  end
end
