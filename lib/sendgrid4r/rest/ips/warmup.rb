# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Ips
      #
      # SendGrid Web API v3 Ip Management - Warmup
      #
      module Warmup
        include SendGrid4r::REST::Request

        WarmupIp = Struct.new(:ip, :start_date)

        def self.create_warmup_ips(resp)
          return resp if resp.nil?
          ips = []
          resp.each do |warmup_ip|
            ips.push(SendGrid4r::REST::Ips::Warmup.create_warmup_ip(warmup_ip))
          end
          ips
        end

        def self.create_warmup_ip(resp)
          return resp if resp.nil?
          WarmupIp.new(
            resp['ip'],
            resp['start_date'].nil? ? nil : Time.at(resp['start_date'])
          )
        end

        def self.url(ip_address = nil)
          url = "#{BASE_URL}/ips/warmup"
          url = "#{url}/#{ip_address}" unless ip_address.nil?
          url
        end

        def get_warmup_ips(&block)
          resp = get(@auth, SendGrid4r::REST::Ips::Warmup.url, &block)
          SendGrid4r::REST::Ips::Warmup.create_warmup_ips(resp)
        end

        def get_warmup_ip(ip_address, &block)
          endpoint = SendGrid4r::REST::Ips::Warmup.url(ip_address)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Ips::Warmup.create_warmup_ip(resp)
        end

        def post_warmup_ip(ip_address, &block)
          endpoint = SendGrid4r::REST::Ips::Warmup.url
          resp = post(@auth, endpoint, ip: ip_address, &block)
          SendGrid4r::REST::Ips::Warmup.create_warmup_ip(resp)
        end

        def delete_warmup_ip(ip_address, &block)
          endpoint = SendGrid4r::REST::Ips::Warmup.url(ip_address)
          delete(@auth, endpoint, &block)
        end
      end
    end
  end
end
