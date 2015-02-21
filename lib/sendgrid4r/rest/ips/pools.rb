# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Ip Management
    #
    module Ips
      #
      # SendGrid Web API v3 Ip Management - Pools
      #
      module Pools
        include SendGrid4r::REST::Request

        Pool = Struct.new(:pool_name, :name, :ips)

        def self.create_pool(resp)
          ips = []
          Array(resp['ips']).each { |ip| ips.push(ip) }
          Pool.new(resp['pool_name'], resp['name'], ips)
        end

        def get_pools
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools")
          pools = []
          resp_a.each do |resp|
            pools.push(SendGrid4r::REST::Ips::Pools.create_pool(resp))
          end
          pools
        end

        def post_pool(name)
          resp = post(
            @auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools", name: name
          )
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def get_pool(name)
          resp = get(
            @auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}"
          )
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def put_pool(name, new_name)
          resp = put(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}",
            name: new_name)
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def delete_pool(name)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}")
        end
      end
    end
  end
end
