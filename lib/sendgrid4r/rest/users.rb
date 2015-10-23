# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Users
    #
    module Users
      include SendGrid4r::REST::Request

      Profile = Struct.new(
        :address, :city, :company, :country, :first_name, :last_name,
        :phone, :state, :website, :zip
      )

      Account = Struct.new(:type, :reputation)

      def self.url(path)
        url = "#{BASE_URL}/user/#{path}"
        url
      end

      def self.create_profile(resp)
        return resp if resp.nil?
        Profile.new(
          resp['address'],
          resp['city'],
          resp['company'],
          resp['country'],
          resp['first_name'],
          resp['last_name'],
          resp['phone'],
          resp['state'],
          resp['website'],
          resp['zip']
        )
      end

      def self.create_account(resp)
        return resp if resp.nil?
        Account.new(
          resp['type'],
          resp['reputation']
        )
      end

      def get_user_profile(&block)
        resp = get(@auth, SendGrid4r::REST::Users.url('profile'), nil, &block)
        SendGrid4r::REST::Users.create_profile(resp)
      end

      def patch_user_profile(params:, &block)
        endpoint = SendGrid4r::REST::Users.url('profile')
        resp = patch(@auth, endpoint, params, &block)
        SendGrid4r::REST::Users.create_profile(resp)
      end

      def get_user_account(&block)
        resp = get(@auth, SendGrid4r::REST::Users.url('account'), nil, &block)
        SendGrid4r::REST::Users.create_account(resp)
      end
    end
  end
end
