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
      include SendGrid4r::REST::Request

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
        ips = []
        resp.each do |ip|
          ips.push(
            SendGrid4r::REST::Whitelabel::Ips.create_ip(ip)
          )
        end
        ips
      end

      def self.create_ip(resp)
        return resp if resp.nil?
        Ip.new(
          resp['id'],
          resp['ip'],
          resp['rdns'],
          SendGrid4r::REST::Whitelabel::Ips.create_users(resp['users']),
          resp['subdomain'],
          resp['domain'],
          resp['valid'],
          resp['legacy'],
          SendGrid4r::REST::Whitelabel::Ips.create_a_record(resp['a_record'])
        )
      end

      def self.create_users(resp)
        return resp if resp.nil?
        users = []
        resp.each do |user|
          users.push(SendGrid4r::REST::Whitelabel::Ips.create_a_record(user))
        end
        users
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
          SendGrid4r::REST::Whitelabel::Ips.create_validation_results(
            resp['validation_results']
          )
        )
      end

      def self.create_validation_results(resp)
        return resp if resp.nil?
        ValidationResults.new(
          SendGrid4r::REST::Whitelabel::Ips.create_validation_result(
            resp['a_record']
          )
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
        endpoint = SendGrid4r::REST::Whitelabel::Ips.url
        resp = get(@auth, endpoint, params, &block)
        SendGrid4r::REST::Whitelabel::Ips.create_ips(resp)
      end

      def post_wl_ip(ip:, subdomain:, domain:, &block)
        params = {}
        params['ip'] = ip
        params['subdomain'] = subdomain
        params['domain'] = domain
        endpoint = SendGrid4r::REST::Whitelabel::Ips.url
        resp = post(@auth, endpoint, params, &block)
        SendGrid4r::REST::Whitelabel::Ips.create_ip(resp)
      end

      def get_wl_ip(id:, &block)
        endpoint = SendGrid4r::REST::Whitelabel::Ips.url(id)
        resp = get(@auth, endpoint, nil, &block)
        SendGrid4r::REST::Whitelabel::Ips.create_ip(resp)
      end

      def delete_wl_ip(id:, &block)
        endpoint = SendGrid4r::REST::Whitelabel::Ips.url(id)
        delete(@auth, endpoint, &block)
      end

      def validate_wl_ip(id:, &block)
        endpoint = SendGrid4r::REST::Whitelabel::Ips.url(id)
        endpoint = "#{endpoint}/validate"
        resp = post(@auth, endpoint, &block)
        SendGrid4r::REST::Whitelabel::Ips.create_result(resp)
      end
    end
  end
end
