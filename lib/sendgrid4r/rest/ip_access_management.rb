# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 IpAccessManagement
  #
  module IpAccessManagement
    include Request

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
      result = resp['result'].map do |activity|
        IpAccessManagement.create_ip_activity(activity)
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
      result = resp['result'].map do |whitelisted_ip|
        IpAccessManagement.create_whitelisted_ip_result(whitelisted_ip)
      end
      WhitelistedIps.new(result)
    end

    def self.create_whitelisted_ip(resp)
      return resp if resp.nil?
      WhitelistedIp.new(
        IpAccessManagement.create_whitelisted_ip_result(resp['result'])
      )
    end

    def self.create_whitelisted_ip_result(resp)
      return resp if resp.nil?
      created_at = Time.at(resp['created_at']) unless resp['created_at'].nil?
      updated_at = Time.at(resp['updated_at']) unless resp['updated_at'].nil?
      WhitelistedIpResult.new(resp['id'], resp['ip'], created_at, updated_at)
    end

    def get_ip_activities(limit: nil, &block)
      params = {}
      params[:limit] = limit unless limit.nil?
      resp = get(@auth, IpAccessManagement.url_activity, params, &block)
      IpAccessManagement.create_ip_activities(resp)
    end

    def get_whitelisted_ips(&block)
      resp = get(@auth, IpAccessManagement.url_whitelist, &block)
      IpAccessManagement.create_whitelisted_ips(resp)
    end

    def post_whitelisted_ips(ips:, &block)
      ips_param = ips.map { |ip| { ip: ip } }
      params = { ips: ips_param }
      resp = post(@auth, IpAccessManagement.url_whitelist, params, &block)
      IpAccessManagement.create_whitelisted_ips(resp)
    end

    def delete_whitelisted_ips(ids:, &block)
      payload = { ids: ids }
      delete(@auth, IpAccessManagement.url_whitelist, nil, payload, &block)
    end

    def get_whitelisted_ip(rule_id:, &block)
      resp = get(@auth, IpAccessManagement.url_whitelist(rule_id), nil, &block)
      IpAccessManagement.create_whitelisted_ip(resp)
    end

    def delete_whitelisted_ip(rule_id:, &block)
      delete(@auth, IpAccessManagement.url_whitelist(rule_id), nil, &block)
    end
  end
end
