# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 SpamReports
  #
  module SpamReports
    include Request

    SpamReport = Struct.new(:created, :email, :ip)

    def self.url(email = nil)
      url = "#{BASE_URL}/suppression/spam_reports"
      url = "#{url}/#{email}" unless email.nil?
      url
    end

    def self.create_spam_reports(resp)
      return resp if resp.nil?
      resp.map { |spam_report| SpamReports.create_spam_report(spam_report) }
    end

    def self.create_spam_report(resp)
      return resp if resp.nil?
      created = Time.at(resp['created']) unless resp['created'].nil?
      SpamReport.new(created, resp['email'], resp['ip'])
    end

    def get_spam_reports(
      start_time: nil, end_time: nil, limit: nil, offset: nil, &block
    )
      params = {}
      params[:start_time] = start_time.to_i unless start_time.nil?
      params[:end_time] = end_time.to_i unless end_time.nil?
      params[:limit] = limit.to_i unless limit.nil?
      params[:offset] = offset.to_i unless offset.nil?
      resp = get(@auth, SpamReports.url, params, &block)
      SpamReports.create_spam_reports(resp)
    end

    def delete_spam_reports(delete_all: nil, emails: nil, &block)
      if delete_all == true
        payload = { delete_all: delete_all }
      else
        payload = { emails: emails }
      end
      delete(@auth, SpamReports.url, nil, payload, &block)
    end

    def get_spam_report(email:, &block)
      params = { email: email }
      resp = get(@auth, SpamReports.url(email), params, &block)
      SpamReports.create_spam_reports(resp)
    end

    def delete_spam_report(email:, &block)
      params = { email: email }
      delete(@auth, SpamReports.url(email), params, &block)
    end
  end
end
