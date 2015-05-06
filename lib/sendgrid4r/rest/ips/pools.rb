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

        def self.create_pools(resp)
          return resp if resp.nil?
          pools = []
          resp.each do |pool|
            pools.push(SendGrid4r::REST::Ips::Pools.create_pool(pool))
          end
          pools
        end

        def self.create_pool(resp)
          return resp if resp.nil?
          ips = []
          Array(resp['ips']).each { |ip| ips.push(ip) }
          Pool.new(resp['pool_name'], resp['name'], ips)
        end

        def self.url(name = nil, ips = nil, ip = nil)
          url = "#{BASE_URL}/ips/pools"
          url = "#{url}/#{name}" unless name.nil?
          url = "#{url}/#{ips}" unless ips.nil?
          url = "#{url}/#{ip}" unless ip.nil?
          url
        end

        def post_pool(name, &block)
          endpoint = SendGrid4r::REST::Ips::Pools.url
          resp = post(@auth, endpoint, name: name, &block)
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def get_pools(&block)
          resp = get(@auth, SendGrid4r::REST::Ips::Pools.url, &block)
          SendGrid4r::REST::Ips::Pools.create_pools(resp)
        end

        def get_pool(name, &block)
          endpoint = SendGrid4r::REST::Ips::Pools.url(name)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def put_pool(name, new_name, &block)
          endpoint = SendGrid4r::REST::Ips::Pools.url(name)
          resp = put(@auth, endpoint, name: new_name, &block)
          SendGrid4r::REST::Ips::Pools.create_pool(resp)
        end

        def delete_pool(name, &block)
          delete(@auth, SendGrid4r::REST::Ips::Pools.url(name), &block)
        end
      end
    end
  end
end
