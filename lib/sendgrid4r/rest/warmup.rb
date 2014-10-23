# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Ips
      module Warmup

        include SendGrid4r::REST::Request

        def get_warmup_ips
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup")
          ips = Array.new
          response.each{|ip|
            ip_address = WarmupIp.create(ip)
            ips.push(ip_address)
          } if response.length > 0
          ips
        end

        def get_warmup_ip(ip_address)
          WarmupIp.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup/#{ip_address}"))
        end

        def post_warmup_ip(ip_address)
          params = Hash.new
          params["ip"] = ip_address
          WarmupIp.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup", params))
        end

        def delete_warmup_ip(ip_address)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup/#{ip_address}")
        end

        class WarmupIp

          attr_accessor :ip, :start_date

          def self.create(value)
            obj = WarmupIp.new
            obj.ip = value["ip"]
            obj.start_date = value["start_date"]
            obj
          end

        end
      end
    end

  end
end
