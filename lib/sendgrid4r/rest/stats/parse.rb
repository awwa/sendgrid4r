# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Stats
    #
    # SendGrid Web API v3 Stats - Parse
    #
    module Parse
      include Request

      def get_parse_stats(
        start_date:, end_date: nil, aggregated_by: nil, &block
      )
        params = {
          start_date: start_date,
          end_date: end_date,
          aggregated_by: aggregated_by
        }
        endpoint = "#{BASE_URL}/user/webhooks/parse/stats"
        resp = get(@auth, endpoint, params, &block)
        Stats.create_top_stats(resp)
      end
    end
  end
end
