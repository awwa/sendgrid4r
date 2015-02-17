# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Stats

      module AggregatedBy
        DAY = "day"
        WEEK = "week"
        MONTH = "month"
      end

      TopStat  = Struct.new(:date, :stats)
      Stat        = Struct.new(:metrics, :name, :type)
      Metric      = Struct.new(:blocks, :bounce_drops,
        :bounces, :clicks, :deferred, :delivered,
        :invalid_emails, :opens, :processed, :requests,
        :spam_report_drops, :spam_reports,
        :unique_clicks, :unique_opens, :unsubscribe_drops,
        :unsubscribes
      )

      def self.create_top_stat(resp)
        stats = Array.new
        resp["stats"].each{|stat|
          stats.push(SendGrid4r::REST::Stats::create_stat(stat))
        }
        TopStat.new(resp["date"], stats)
      end
      def self.create_stat(resp)
        stat =
          SendGrid4r::REST::Stats::create_metric(
            resp["metrics"]
          )
        Stat.new(stat, resp["name"], resp["type"])
      end

      def self.create_metric(resp)
        Metric.new(
          resp["blocks"],
          resp["bounce_drops"],
          resp["bounces"],
          resp["clicks"],
          resp["deferred"],
          resp["delivered"],
          resp["invalid_emails"],
          resp["opens"],
          resp["processed"],
          resp["requests"],
          resp["spam_report_drops"],
          resp["spam_reports"],
          resp["unique_clicks"],
          resp["unique_opens"],
          resp["unsubscribe_drops"],
          resp["unsubscribe"])
      end
    end
  end
end
