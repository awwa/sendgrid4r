# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Subusers
    #
    module Subusers
      include SendGrid4r::REST::Request

      Subuser = Struct.new(
        :id, :username, :email, :password, :ips, :reputation, :disabled
      )
      Ips = Struct.new(:ips)

      def self.url(subuser_name = nil)
        url = "#{BASE_URL}/subusers"
        url = "#{url}/#{subuser_name}" unless subuser_name.nil?
        url
      end

      def self.create_subusers(resp)
        return resp if resp.nil?
        subusers = []
        resp.each do |subuser|
          subusers.push(SendGrid4r::REST::Subusers.create_subuser(subuser))
        end
        subusers
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
        Monitor.new(
          resp['email'],
          resp['frequency']
        )
      end

      def get_subusers(limit: nil, offset: nil, username: nil, &block)
        params = {}
        params['limit'] = limit unless limit.nil?
        params['offset'] = offset unless offset.nil?
        params['username'] = username unless username.nil?
        resp = get(@auth, SendGrid4r::REST::Subusers.url, params, &block)
        SendGrid4r::REST::Subusers.create_subusers(resp)
      end

      def post_subuser(username:, email:, password:, ips:, &block)
        params = {}
        params['username'] = username
        params['email'] = email
        params['password'] = password
        params['ips'] = ips
        resp = post(@auth, SendGrid4r::REST::Subusers.url, params, &block)
        SendGrid4r::REST::Subusers.create_subuser(resp)
      end

      def patch_subuser(username:, disabled:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        payload = {}
        payload['disabled'] = disabled
        resp = patch(@auth, endpoint, payload, &block)
        SendGrid4r::REST::Subusers.create_subuser(resp)
      end

      def delete_subuser(username:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        delete(@auth, endpoint, &block)
      end

      def get_subuser_monitor(username:, email:, frequency:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        endpoint = "#{endpoint}/monitor"
        payload = {}
        payload['email'] = email
        payload['frequency'] = frequency
        resp = post(@auth, endpoint, payload, &block)
        SendGrid4r::REST::Subusers.create_monitor(resp)
      end

      def post_subuser_monitor(username:, email:, frequency:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        endpoint = "#{endpoint}/monitor"
        payload = {}
        payload['email'] = email
        payload['frequency'] = frequency
        resp = post(@auth, endpoint, payload, &block)
        SendGrid4r::REST::Subusers.create_monitor(resp)
      end

      def put_subuser_monitor(username:, email:, frequency:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        endpoint = "#{endpoint}/monitor"
        payload = {}
        payload['email'] = email
        payload['frequency'] = frequency
        resp = put(@auth, endpoint, payload, &block)
        SendGrid4r::REST::Subusers.create_monitor(resp)
      end

      def delete_subuser_monitor(username:, &block)
        endpoint = SendGrid4r::REST::Subusers.url(username)
        endpoint = "#{endpoint}/monitor"
        delete(@auth, endpoint, &block)
      end

      def get_subuser_reputation(usernames:, &block)
        params = ''
        usernames.each do |username|
          params += "usernames=#{username}&"
        end
        endpoint = SendGrid4r::REST::Subusers.url
        endpoint = "#{endpoint}/reputations?#{params}"
        resp = get(@auth, endpoint, usernames, &block)
        SendGrid4r::REST::Subusers.create_subusers(resp)
      end

      def put_subuser_assigned_ips(username:, ips:, &block)
        endpoint = "#{SendGrid4r::REST::Subusers.url(username)}/ips"
        resp = put(@auth, endpoint, ips, &block)
        SendGrid4r::REST::Subusers.create_subuser(resp)
      end
    end
  end
end
