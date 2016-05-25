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

    Email = Struct.new(:email)

    Username = Struct.new(:username, :user_id)

    Credits = Struct.new(
      :remain, :total, :overage, :used, :last_reset, :next_reset,
      :reset_frequency
    )

    Password = Struct.new(:new_password, :old_password)

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

    def self.create_email(resp)
      return resp if resp.nil?
      Email.new(resp['email'])
    end

    def self.create_username(resp)
      return resp if resp.nil?
      Username.new(resp['username'], resp['user_id'])
    end

    def self.create_credits(resp)
      return resp if resp.nil?
      Credits.new(
        resp['remain'],
        resp['total'],
        resp['overage'],
        resp['used'],
        resp['last_reset'],
        resp['next_reset'],
        resp['reset_frequency']
      )
    end

    def self.create_password(resp)
      return resp if resp.nil?
      Password.new(resp['new_password'], resp['old_password'])
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

    def get_user_email(&block)
      resp = get(@auth, Users.url(:email), nil, &block)
      Users.create_email(resp)
    end

    def put_user_email(email:, &block)
      params = { email: email }
      resp = put(@auth, Users.url(:email), params, &block)
      Users.create_email(resp)
    end

    def get_user_username(&block)
      resp = get(@auth, Users.url(:username), nil, &block)
      Users.create_username(resp)
    end

    def put_user_username(username:, &block)
      params = { username: username }
      resp = put(@auth, Users.url(:username), params, &block)
      Users.create_username(resp)
    end

    def get_user_credits(&block)
      resp = get(@auth, Users.url(:credits), &block)
      Users.create_credits(resp)
    end

    def put_user_password(new_password:, old_password:, &block)
      params = {
        new_password: new_password,
        old_password: old_password
      }
      resp = put(@auth, Users.url(:password), params, &block)
      Users.create_password(resp)
    end
  end
end
