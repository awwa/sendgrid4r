# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Subusers
  #
  module Subusers
    include Request

    Subuser = Struct.new(
      :id, :username, :email, :password, :ips, :reputation, :disabled
    )
    Ips = Struct.new(:ips)

    def self.url(subuser_name = nil)
      url = "#{BASE_URL}/subusers"
      url = "#{url}/#{subuser_name}" unless subuser_name.nil?
      url
    end

    def self.url_monitor(username)
      "#{Subusers.url(username)}/monitor"
    end

    def self.create_subusers(resp)
      return resp if resp.nil?
      resp.map { |subuser| Subusers.create_subuser(subuser) }
    end

    def self.create_subuser(resp)
      return resp if resp.nil?
      Subuser.new(
        resp['id'],
        resp['username'],
        resp['email'],
        resp['password'],
        resp['ips'],
        resp['reputation'],
        resp['disabled']
      )
    end

    Monitor = Struct.new(:email, :frequency)

    def self.create_monitor(resp)
      return resp if resp.nil?
      Monitor.new(resp['email'], resp['frequency'])
    end

    def get_subusers(limit: nil, offset: nil, username: nil, &block)
      params = {}
      params[:limit] = limit unless limit.nil?
      params[:offset] = offset unless offset.nil?
      params[:username] = username unless username.nil?
      resp = get(@auth, Subusers.url, params, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_subusers(r) }
    end

    def post_subuser(username:, email:, password:, ips:, &block)
      params = {
        username: username,
        email: email,
        password: password,
        ips: ips
      }
      resp = post(@auth, Subusers.url, params, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_subuser(r) }
    end

    def patch_subuser(username:, disabled:, &block)
      payload = { disabled: disabled }
      resp = patch(@auth, Subusers.url(username), payload, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_subuser(r) }
    end

    def delete_subuser(username:, &block)
      delete(@auth, Subusers.url(username), &block)
    end

    def get_subuser_monitor(username:, &block)
      endpoint = Subusers.url_monitor(username)
      resp = get(@auth, endpoint, nil, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_monitor(r) }
    end

    def post_subuser_monitor(username:, email:, frequency:, &block)
      endpoint = Subusers.url_monitor(username)
      payload = { email: email, frequency: frequency }
      resp = post(@auth, endpoint, payload, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_monitor(r) }
    end

    def put_subuser_monitor(username:, email:, frequency:, &block)
      endpoint = Subusers.url_monitor(username)
      payload = { email: email, frequency: frequency }
      resp = put(@auth, endpoint, payload, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_monitor(r) }
    end

    def delete_subuser_monitor(username:, &block)
      delete(@auth, Subusers.url_monitor(username), &block)
    end

    def get_subuser_reputation(usernames:, &block)
      params = ''
      usernames.each { |username| params += "usernames=#{username}&" }
      endpoint = "#{Subusers.url}/reputations?#{params}"
      resp = get(@auth, endpoint, nil, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_subusers(r) }
    end

    def put_subuser_assigned_ips(username:, ips:, &block)
      resp = put(@auth, "#{Subusers.url(username)}/ips", ips, &block)
      finish(resp, @raw_resp) { |r| Subusers.create_subuser(r) }
    end
  end
end
