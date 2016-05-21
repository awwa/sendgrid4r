# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Users
  #
  module Users
    include Request

    Profile = Struct.new(
      :address, :city, :company, :country, :first_name, :last_name,
      :phone, :state, :website, :zip
    )

    Account = Struct.new(:type, :reputation)

    def self.url(path)
      "#{BASE_URL}/user/#{path}"
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
      Account.new(resp['type'], resp['reputation'])
    end

    def get_user_profile(&block)
      resp = get(@auth, Users.url(:profile), nil, &block)
      Users.create_profile(resp)
    end

    def patch_user_profile(params:, &block)
      resp = patch(@auth, Users.url(:profile), params, &block)
      Users.create_profile(resp)
    end

    def get_user_account(&block)
      resp = get(@auth, Users.url(:account), nil, &block)
      Users.create_account(resp)
    end
  end
end
