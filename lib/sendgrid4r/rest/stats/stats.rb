# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Stats
    #
    module Stats
      #
      # SendGrid Web API v3 Stats - AggregatedBy
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
        stats = []
        resp['stats'].each do |stat|
          stats.push(SendGrid4r::REST::Stats.create_stat(stat))
        end
        TopStat.new(resp['date'], stats)
      end

      def self.create_stat(resp)
        return resp if resp.nil?
        stat = SendGrid4r::REST::Stats.create_metric(resp['metrics'])
        Stat.new(stat, resp['name'], resp['type'])
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
        top_stats = []
        resp_a.each do |resp|
          top_stats.push(SendGrid4r::REST::Stats.create_top_stat(resp))
        end
        top_stats
      end
    end
  end
end
