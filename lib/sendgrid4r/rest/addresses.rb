# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Ips
      module Addresses

        include SendGrid4r::REST::Request

        def get_ips
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips")
          ips = Array.new
          response.each{|ip|
            ip_address = Address.create(ip)
            ips.push(ip_address)
          } if response.length > 0
          ips
        end

        def get_ip(ip)
          Address.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/#{ip}"))
        end

        def post_ip_to_pool(pool_name, ip)
          params = Hash.new
          params["ip"] = ip
          Address.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{pool_name}/ips", params))
        end

        def delete_ip_from_pool(pool_name, ip)
          delete(@auth,"#{SendGrid4r::Client::BASE_URL}/ips/pools/#{pool_name}/ips/#{ip}")
        end

      end

      class Address

        attr_accessor :ip, :pools, :warmup, :start_date, :pool_name

        def self.create(value)
          obj = Address.new
          obj.ip = value["ip"]
          obj.pools = []
          value["pools"].each{|pool|
            ver = Pool.create(pool)
            obj.pools.push(ver)
          } if value["pools"] != nil
          obj.warmup = value["warmup"]
          obj.start_date = value["start_date"]
          obj.pool_name = value["pool_name"]
          obj
        end

      end

    end

  end
end
