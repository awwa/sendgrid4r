# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Ips
      module Warmup

        include SendGrid4r::REST::Request

        WarmupIp = Struct.new(:ip, :start_date)

        def self.create_warmup_ip(resp)
          WarmupIp.new(resp["ip"], resp["start_date"])
        end

        def get_warmup_ips
          ips = Array.new
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup")
          resp_a.each{|resp|
            ips.push(SendGrid4r::REST::Ips::Warmup::create_warmup_ip(resp))
          }
          ips
        end

        def get_warmup_ip(ip_address)
          resp = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup/#{ip_address}")
          SendGrid4r::REST::Ips::Warmup::create_warmup_ip(resp)
        end

        def post_warmup_ip(ip_address)
          resp = post(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup", {"ip" => ip_address})
          SendGrid4r::REST::Ips::Warmup::create_warmup_ip(resp)
        end

        def delete_warmup_ip(ip_address)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/warmup/#{ip_address}")
        end

      end
    end
  end
end
