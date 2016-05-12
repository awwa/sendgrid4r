# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Ip Management
  #
  module Ips
    #
    # SendGrid Web API v3 Ip Management - Pools
    #
    module Addresses
      include Request

      Address = Struct.new(
        :ip, :pools, :warmup, :start_date, :subusers, :rdns, :pool_name
      )

      def self.create_addresses(resp)
        return resp if resp.nil?
        resp.map { |address| Ips::Addresses.create_address(address) }
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

      def post_ip_to_pool(pool_name:, ip:, &block)
        resp = post(@auth, Ips::Pools.url(pool_name, 'ips'), ip: ip, &block)
        Ips::Addresses.create_address(resp)
      end

      def get_ips(&block)
        resp = get(@auth, Ips::Addresses.url, &block)
        Ips::Addresses.create_addresses(resp)
      end

      def get_ips_assigned(&block)
        resp = get(@auth, Ips::Addresses.url('assigned'), &block)
        Ips::Addresses.create_addresses(resp)
      end

      def get_ip(ip:, &block)
        resp = get(@auth, Ips::Addresses.url(ip), &block)
        Ips::Addresses.create_address(resp)
      end

      def delete_ip_from_pool(pool_name:, ip:, &block)
        delete(@auth, Ips::Pools.url(pool_name, 'ips', ip), &block)
      end
    end
  end
end
