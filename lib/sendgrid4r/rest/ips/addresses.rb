# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Ips

      Address = Struct.new(:ip, :pools, :warmup, :start_date, :subusers, :rdns, :pool_name)

      def self.create_address(resp)
        Address.new(
          resp["ip"],
          resp["pools"],
          resp["warmup"],
          resp["start_date"],
          resp["subusers"],
          resp["rdns"],
          resp["pool_name"]
        )
      end

      module Addresses

        include SendGrid4r::REST::Request

        def get_ips
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips")
          ips = Array.new
          resp_a.each{|resp|
            ips.push(SendGrid4r::REST::Ips::create_address(resp))
          }
          ips
        end

        def get_ips_assigned
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/assigned")
          ips = Array.new
          resp_a.each{|resp|
            ips.push(SendGrid4r::REST::Ips::create_address(resp))
          }
          ips
        end

        def get_ip(ip)
          resp = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/#{ip}")
          SendGrid4r::REST::Ips::create_address(resp)
        end

        def post_ip_to_pool(pool_name, ip)
          resp = post(
            @auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{pool_name}/ips", {:ip => ip})
          SendGrid4r::REST::Ips::create_address(resp)
        end

        def delete_ip_from_pool(pool_name, ip)
          delete(@auth,"#{SendGrid4r::Client::BASE_URL}/ips/pools/#{pool_name}/ips/#{ip}")
        end

      end
    end
  end
end
