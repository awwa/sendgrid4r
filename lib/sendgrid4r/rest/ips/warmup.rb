# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Ips
    #
    # SendGrid Web API v3 Ip Management - Warmup
    #
    module Warmup
      include Request

      WarmupIp = Struct.new(:ip, :start_date)

      def self.create_warmup_ips(resp)
        return resp if resp.nil?
        ips = []
        resp.each do |warmup_ip|
          ips.push(Ips::Warmup.create_warmup_ip(warmup_ip))
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
        resp = get(@auth, Ips::Warmup.url, &block)
        Ips::Warmup.create_warmup_ips(resp)
      end

      def get_warmup_ip(ip:, &block)
        resp = get(@auth, Ips::Warmup.url(ip), &block)
        Ips::Warmup.create_warmup_ip(resp)
      end

      def post_warmup_ip(ip:, &block)
        resp = post(@auth, Ips::Warmup.url, ip: ip, &block)
        Ips::Warmup.create_warmup_ip(resp)
      end

      def delete_warmup_ip(ip:, &block)
        delete(@auth, Ips::Warmup.url(ip), &block)
      end
    end
  end
end
