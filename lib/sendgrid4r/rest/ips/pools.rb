# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Ip Management
  #
  module Ips
    #
    # SendGrid Web API v3 Ip Management - Pools
    #
    module Pools
      include Request

      Pool = Struct.new(:pool_name, :name, :ips)

      def self.create_pools(resp)
        return resp if resp.nil?
        resp.map { |pool| Ips::Pools.create_pool(pool) }
      end

      def self.create_pool(resp)
        return resp if resp.nil?
        Pool.new(resp['pool_name'], resp['name'], resp['ips'])
      end

      def self.url(name = nil, ips = nil, ip = nil)
        url = "#{BASE_URL}/ips/pools"
        url = "#{url}/#{name}" unless name.nil?
        url = "#{url}/#{ips}" unless ips.nil?
        url = "#{url}/#{ip}" unless ip.nil?
        url
      end

      def post_pool(name:, &block)
        resp = post(@auth, Ips::Pools.url, name: name, &block)
        finish(resp, @raw_resp) { |r| Ips::Pools.create_pool(r) }
      end

      def get_pools(&block)
        resp = get(@auth, Ips::Pools.url, &block)
        finish(resp, @raw_resp) { |r| Ips::Pools.create_pools(r) }
      end

      def get_pool(name:, &block)
        resp = get(@auth, Ips::Pools.url(name), &block)
        finish(resp, @raw_resp) { |r| Ips::Pools.create_pool(r) }
      end

      def put_pool(name:, new_name:, &block)
        resp = put(@auth, Ips::Pools.url(name), name: new_name, &block)
        finish(resp, @raw_resp) { |r| Ips::Pools.create_pool(r) }
      end

      def delete_pool(name:, &block)
        delete(@auth, Ips::Pools.url(name), &block)
      end
    end
  end
end
