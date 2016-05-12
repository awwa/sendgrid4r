# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Whitelabel
  #
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Ips
    #
    module Ips
      include Request

      Ip = Struct.new(
        :id, :ip, :rdns, :users, :subdomain, :domain, :valid, :legacy,
        :a_record
      )
      User = Struct.new(:username, :user_id)
      ARecord = Struct.new(:host, :type, :data, :valid)

      def self.url(id = nil)
        url = "#{BASE_URL}/whitelabel/ips"
        url = "#{url}/#{id}" unless id.nil?
        url
      end

      def self.create_ips(resp)
        return resp if resp.nil?
        resp.map { |ip| Ips.create_ip(ip) }
      end

      def self.create_ip(resp)
        return resp if resp.nil?
        Ip.new(
          resp['id'],
          resp['ip'],
          resp['rdns'],
          Ips.create_users(resp['users']),
          resp['subdomain'],
          resp['domain'],
          resp['valid'],
          resp['legacy'],
          Ips.create_a_record(resp['a_record'])
        )
      end

      def self.create_users(resp)
        return resp if resp.nil?
        resp.map { |user| Ips.create_a_record(user) }
      end

      def self.create_a_record(resp)
        return resp if resp.nil?
        ARecord.new(resp['host'], resp['type'], resp['data'], resp['valid'])
      end

      Result = Struct.new(:id, :valid, :validation_results)
      ValidationResults = Struct.new(:a_record)
      ValidationResult = Struct.new(:valid, :reason)

      def self.create_result(resp)
        return resp if resp.nil?
        Result.new(
          resp['id'],
          resp['valid'],
          Ips.create_validation_results(resp['validation_results'])
        )
      end

      def self.create_validation_results(resp)
        return resp if resp.nil?
        ValidationResults.new(
          Ips.create_validation_result(resp['a_record'])
        )
      end

      def self.create_validation_result(resp)
        return resp if resp.nil?
        ValidationResult.new(resp['valid'], resp['reason'])
      end

      def get_wl_ips(ip: nil, limit: nil, offset: nil, &block)
        params = {}
        params['ip'] = ip unless ip.nil?
        params['limit'] = limit unless limit.nil?
        params['offset'] = offset unless offset.nil?
        resp = get(@auth, Ips.url, params, &block)
        Ips.create_ips(resp)
      end

      def post_wl_ip(ip:, subdomain:, domain:, &block)
        params = {}
        params['ip'] = ip
        params['subdomain'] = subdomain
        params['domain'] = domain
        resp = post(@auth, Ips.url, params, &block)
        Ips.create_ip(resp)
      end

      def get_wl_ip(id:, &block)
        resp = get(@auth, Ips.url(id), nil, &block)
        Ips.create_ip(resp)
      end

      def delete_wl_ip(id:, &block)
        delete(@auth, Ips.url(id), &block)
      end

      def validate_wl_ip(id:, &block)
        resp = post(@auth, "#{Ips.url(id)}/validate", &block)
        Ips.create_result(resp)
      end
    end
  end
end
