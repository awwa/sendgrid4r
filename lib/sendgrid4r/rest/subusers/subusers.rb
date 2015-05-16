# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Subusers
    #
    module Subusers
      include SendGrid4r::REST::Request

      Subuser = Struct.new(:id, :username, :email, :password, :ips, :reputation)
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
          resp['reputation']
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

      def get_subuser_reputation(usernames:, &block)
        params = ''
        usernames.each do |username|
          params += "usernames=#{username}&"
        end
        endpoint = "#{SendGrid4r::REST::Subusers.url}/reputations?#{params}"
        resp = get(@auth, endpoint, usernames, &block)
        SendGrid4r::REST::Subusers.create_subusers(resp)
      end

      def put_subuser_assigned_ips(username:, &block)
        endpoint = "#{SendGrid4r::REST::Subusers.url(username)}/ips"
        resp = put(@auth, endpoint, nil, &block)
        SendGrid4r::REST::Subusers.create_subuser(resp)
      end
    end
  end
end
