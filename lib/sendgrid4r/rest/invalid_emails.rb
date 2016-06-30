# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 InvalidEmails
  #
  module InvalidEmails
    include Request

    InvalidEmail = Struct.new(:created, :email, :reason)

    def self.url(email = nil)
      url = "#{BASE_URL}/suppression/invalid_emails"
      url = "#{url}/#{email}" unless email.nil?
      url
    end

    def self.create_invalid_emails(resp)
      return resp if resp.nil?
      resp.map do |invalid_email|
        InvalidEmails.create_invalid_email(invalid_email)
      end
    end

    def self.create_invalid_email(resp)
      return resp if resp.nil?
      created = Time.at(resp['created']) unless resp['created'].nil?
      InvalidEmail.new(created, resp['email'], resp['reason'])
    end

    def get_invalid_emails(
      start_time: nil, end_time: nil, limit: nil, offset: nil, &block
    )
      params = {}
      params[:start_time] = start_time.to_i unless start_time.nil?
      params[:end_time] = end_time.to_i unless end_time.nil?
      params[:limit] = limit.to_i unless limit.nil?
      params[:offset] = offset.to_i unless offset.nil?
      resp = get(@auth, InvalidEmails.url, params, &block)
      finish(resp, @raw_resp) { |r| InvalidEmails.create_invalid_emails(r) }
    end

    def delete_invalid_emails(delete_all: nil, emails: nil, &block)
      if delete_all
        payload = { delete_all: delete_all }
      else
        payload = { emails: emails }
      end
      delete(@auth, InvalidEmails.url, nil, payload, &block)
    end

    def get_invalid_email(email:, &block)
      resp = get(@auth, InvalidEmails.url(email), &block)
      finish(resp, @raw_resp) { |r| InvalidEmails.create_invalid_emails(r) }
    end

    def delete_invalid_email(email:, &block)
      delete(@auth, InvalidEmails.url(email), &block)
    end
  end
end
