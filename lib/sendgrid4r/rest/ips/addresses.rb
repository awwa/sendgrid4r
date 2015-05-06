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
      module Addresses
        include SendGrid4r::REST::Request

        Address = Struct.new(
          :ip, :pools, :warmup, :start_date, :subusers, :rdns, :pool_name)

        def self.create_addresses(resp)
          return resp if resp.nil?
          ips = []
          resp.each do |address|
            ips.push(SendGrid4r::REST::Ips::Addresses.create_address(address))
          end
          ips
        end

        def self.create_address(resp)
          return resp if resp.nil?
          Address.new(
            resp['ip'],
            resp['pools'],
            resp['warmup'],
            resp['start_date'].nil? ? nil : Time.at(resp['start_date']),
            resp['subusers'],
            resp['rdns'],
            resp['pool_name']
          )
        end

        def self.url(ip = nil)
          url = "#{BASE_URL}/ips"
          url = "#{url}/#{ip}" unless ip.nil?
          url
        end

        def post_ip_to_pool(pool_name, ip, &block)
          endpoint = SendGrid4r::REST::Ips::Pools.url(pool_name, 'ips')
          resp = post(@auth, endpoint, ip: ip, &block)
          SendGrid4r::REST::Ips::Addresses.create_address(resp)
        end

        def get_ips(&block)
          resp = get(@auth, SendGrid4r::REST::Ips::Addresses.url, &block)
          SendGrid4r::REST::Ips::Addresses.create_addresses(resp)
        end

        def get_ips_assigned(&block)
          endpoint = SendGrid4r::REST::Ips::Addresses.url('assigned')
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Ips::Addresses.create_addresses(resp)
        end

        def get_ip(ip, &block)
          endpoint = SendGrid4r::REST::Ips::Addresses.url(ip)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Ips::Addresses.create_address(resp)
        end

        def delete_ip_from_pool(pool_name, ip, &block)
          endpoint = SendGrid4r::REST::Ips::Pools.url(pool_name, 'ips', ip)
          delete(@auth, endpoint, &block)
        end
      end
    end
  end
end
