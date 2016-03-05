# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 InvalidEmails
    #
    module InvalidEmails
      include SendGrid4r::REST::Request

      InvalidEmail = Struct.new(
        :created, :email, :reason
      )

      def self.url(email = nil)
        url = "#{BASE_URL}/suppression/invalid_emails"
        url = "#{url}/#{email}" unless email.nil?
        url
      end

      def self.create_invalid_emails(resp)
        return resp if resp.nil?
        invalid_emails = []
        resp.each do |invalid_email|
          invalid_emails.push(
            SendGrid4r::REST::InvalidEmails.create_invalid_email(invalid_email)
          )
        end
        invalid_emails
      end

      def self.create_invalid_email(resp)
        return resp if resp.nil?
        created = Time.at(resp['created']) unless resp['created'].nil?
        InvalidEmail.new(
          created,
          resp['email'],
          resp['reason']
        )
      end

      def get_invalid_emails(
        start_time: nil, end_time: nil, limit: nil, offset: nil, &block
      )
        params = {}
        params['start_time'] = start_time.to_i unless start_time.nil?
        params['end_time'] = end_time.to_i unless end_time.nil?
        params['limit'] = limit.to_i unless limit.nil?
        params['offset'] = offset.to_i unless offset.nil?
        resp = get(@auth, SendGrid4r::REST::InvalidEmails.url, params, &block)
        SendGrid4r::REST::InvalidEmails.create_invalid_emails(resp)
      end

      def delete_invalid_emails(delete_all: nil, emails: nil, &block)
        endpoint = SendGrid4r::REST::InvalidEmails.url
        payload = {}
        if delete_all == true
          payload['delete_all'] = delete_all
        else
          payload['emails'] = emails
        end
        delete(@auth, endpoint, nil, payload, &block)
      end

      def get_invalid_email(email:, &block)
        endpoint = SendGrid4r::REST::InvalidEmails.url(email)
        params = {}
        params['email'] = email
        resp = get(@auth, endpoint, params, &block)
        SendGrid4r::REST::InvalidEmails.create_invalid_emails(resp)
      end

      def delete_invalid_email(email:, &block)
        endpoint = SendGrid4r::REST::InvalidEmails.url(email)
        params = {}
        params['email'] = email
        delete(@auth, endpoint, params, &block)
      end
    end
  end
end
