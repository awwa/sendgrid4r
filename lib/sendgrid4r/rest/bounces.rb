# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Subusers
  #
  module Bounces
    include Request

    Bounce = Struct.new(:created, :email, :reason, :status)

    def self.url(email = nil)
      url = "#{BASE_URL}/suppression/bounces"
      url = "#{url}/#{email}" unless email.nil?
      url
    end

    def self.create_bounces(resp)
      return resp if resp.nil?
      resp.map { |bounce| Bounces.create_bounce(bounce) }
    end

    def self.create_bounce(resp)
      return resp if resp.nil?
      created = Time.at(resp['created']) unless resp['created'].nil?
      Bounce.new(created, resp['email'], resp['reason'], resp['status'])
    end

    def get_bounces(start_time: nil, end_time: nil, &block)
      params = {}
      params[:start_time] = start_time.to_i unless start_time.nil?
      params[:end_time] = end_time.to_i unless end_time.nil?
      resp = get(@auth, Bounces.url, params, &block)
      finish(resp, @raw_resp) { |r| Bounces.create_bounces(r) }
    end

    def delete_bounces(delete_all: nil, emails: nil, &block)
      if delete_all
        payload = { delete_all: delete_all }
      else
        payload = { emails: emails }
      end
      delete(@auth, Bounces.url, nil, payload, &block)
    end

    # TODO duplicate email
    def get_bounce(email:, &block)
      params = { email: email }
      resp = get(@auth, Bounces.url(email), params, &block)
      finish(resp, @raw_resp) { |r| Bounces.create_bounces(r) }
    end

    def delete_bounce(email:, &block)
      params = { email: email }
      delete(@auth, Bounces.url(email), params, &block)
    end
  end
end
