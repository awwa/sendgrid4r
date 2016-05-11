# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 IpAccessManagement
  #
  module IpAccessManagement
    include SendGrid4r::REST::Request

    IpActivities = Struct.new(:result)

    IpActivity = Struct.new(
      :allowed, :auth_method, :first_at, :ip, :last_at, :location
    )

    WhitelistedIps = Struct.new(:result)

    WhitelistedIp = Struct.new(:result)

    WhitelistedIpResult = Struct.new(:id, :ip, :created_at, :updated_at)

    def self.url_activity
      "#{BASE_URL}/access_settings/activity"
    end

    def self.url_whitelist(rule_id = nil)
      url = "#{BASE_URL}/access_settings/whitelist"
      url = "#{url}/#{rule_id}" unless rule_id.nil?
      url
    end

    def self.create_ip_activities(resp)
      return resp if resp.nil?
      result = []
      resp['result'].each do |activity|
        result.push(
          SendGrid4r::REST::IpAccessManagement.create_ip_activity(activity)
        )
      end
      IpActivities.new(result)
    end

    def self.create_ip_activity(resp)
      return resp if resp.nil?
      first_at = Time.at(resp['first_at']) unless resp['first_at'].nil?
      last_at = Time.at(resp['last_at']) unless resp['last_at'].nil?
      IpActivity.new(
        resp['allowed'],
        resp['auth_method'],
        first_at,
        resp['ip'],
        last_at,
        resp['location']
      )
    end

    def self.create_whitelisted_ips(resp)
      return resp if resp.nil?
      result = []
      resp['result'].each do |whitelisted_ip|
        result.push(
          SendGrid4r::REST::IpAccessManagement.create_whitelisted_ip_result(
            whitelisted_ip
          )
        )
      end
      WhitelistedIps.new(result)
    end

    def self.create_whitelisted_ip(resp)
      return resp if resp.nil?
      WhitelistedIp.new(
        SendGrid4r::REST::IpAccessManagement.create_whitelisted_ip_result(
          resp['result']
        )
      )
    end

    def self.create_whitelisted_ip_result(resp)
      return resp if resp.nil?
      created_at = Time.at(resp['created_at']) unless resp['created_at'].nil?
      updated_at = Time.at(resp['updated_at']) unless resp['updated_at'].nil?
      WhitelistedIpResult.new(resp['id'], resp['ip'], created_at, updated_at)
    end

    def get_ip_activities(limit: nil, &block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_activity
      params = {}
      params['limit'] = limit unless limit.nil?
      resp = get(@auth, endpoint, params, &block)
      SendGrid4r::REST::IpAccessManagement.create_ip_activities(resp)
    end

    def get_whitelisted_ips(&block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_whitelist
      resp = get(@auth, endpoint, &block)
      SendGrid4r::REST::IpAccessManagement.create_whitelisted_ips(resp)
    end

    def post_whitelisted_ips(ips:, &block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_whitelist
      ips_param = []
      ips.each do |ip|
        ip_param = {}
        ip_param['ip'] = ip
        ips_param.push(ip_param)
      end
      params = {}
      params['ips'] = ips_param
      resp = post(@auth, endpoint, params, &block)
      SendGrid4r::REST::IpAccessManagement.create_whitelisted_ips(resp)
    end

    def delete_whitelisted_ips(ids:, &block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_whitelist
      payload = {}
      payload['ids'] = ids
      delete(@auth, endpoint, nil, payload, &block)
    end

    def get_whitelisted_ip(rule_id:, &block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_whitelist(rule_id)
      resp = get(@auth, endpoint, nil, &block)
      SendGrid4r::REST::IpAccessManagement.create_whitelisted_ip(resp)
    end

    def delete_whitelisted_ip(rule_id:, &block)
      endpoint = SendGrid4r::REST::IpAccessManagement.url_whitelist(rule_id)
      delete(@auth, endpoint, nil, &block)
    end
  end
end
