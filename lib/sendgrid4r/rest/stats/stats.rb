# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Stats
  #
  module Stats
    #
    # [DEPRECATED] SendGrid Web API v3 Stats - AggregatedBy
    #
    module AggregatedBy
      DAY = 'day'
      WEEK = 'week'
      MONTH = 'month'
    end

    TopStat = Struct.new(:date, :stats)
    Stat        = Struct.new(:metrics, :name, :type)
    Metric      = Struct.new(
      :blocks,
      :bounce_drops,
      :bounces,
      :clicks,
      :deferred,
      :delivered,
      :drops,
      :invalid_emails,
      :opens,
      :processed,
      :requests,
      :spam_report_drops,
      :spam_reports,
      :unique_clicks,
      :unique_opens,
      :unsubscribe_drops,
      :unsubscribes,
      :received
    )

    def self.create_top_stat(resp)
      return resp if resp.nil?
      stats = resp['stats'].map { |stat| Stats.create_stat(stat) }
      TopStat.new(resp['date'], stats)
    end

    def self.create_stat(resp)
      return resp if resp.nil?
      Stat.new(Stats.create_metric(resp['metrics']), resp['name'], resp['type'])
    end

    def self.create_metric(resp)
      return resp if resp.nil?
      Metric.new(
        resp['blocks'],       resp['bounce_drops'],
        resp['bounces'],      resp['clicks'],
        resp['deferred'],     resp['delivered'],
        resp['drops'],        resp['invalid_emails'],
        resp['opens'],        resp['processed'],
        resp['requests'],     resp['spam_report_drops'],
        resp['spam_reports'], resp['unique_clicks'],
        resp['unique_opens'], resp['unsubscribe_drops'],
        resp['unsubscribes'], resp['received']
      )
    end

    def self.create_top_stats(resp_a)
      return resp_a if resp_a.nil?
      resp_a.map { |resp| Stats.create_top_stat(resp) }
    end
  end
end
