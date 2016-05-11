# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 SpamReports
  #
  module SpamReports
    include SendGrid4r::REST::Request

    SpamReport = Struct.new(
      :created, :email, :ip
    )

    def self.url(email = nil)
      url = "#{BASE_URL}/suppression/spam_reports"
      url = "#{url}/#{email}" unless email.nil?
      url
    end

    def self.create_spam_reports(resp)
      return resp if resp.nil?
      spam_reports = []
      resp.each do |spam_report|
        spam_reports.push(
          SendGrid4r::REST::SpamReports.create_spam_report(spam_report)
        )
      end
      spam_reports
    end

    def self.create_spam_report(resp)
      return resp if resp.nil?
      created = Time.at(resp['created']) unless resp['created'].nil?
      SpamReport.new(
        created,
        resp['email'],
        resp['ip']
      )
    end

    def get_spam_reports(
      start_time: nil, end_time: nil, limit: nil, offset: nil, &block
    )
      params = {}
      params['start_time'] = start_time.to_i unless start_time.nil?
      params['end_time'] = end_time.to_i unless end_time.nil?
      params['limit'] = limit.to_i unless limit.nil?
      params['offset'] = offset.to_i unless offset.nil?
      resp = get(@auth, SendGrid4r::REST::SpamReports.url, params, &block)
      SendGrid4r::REST::SpamReports.create_spam_reports(resp)
    end

    def delete_spam_reports(delete_all: nil, emails: nil, &block)
      endpoint = SendGrid4r::REST::SpamReports.url
      payload = {}
      if delete_all == true
        payload['delete_all'] = delete_all
      else
        payload['emails'] = emails
      end
      delete(@auth, endpoint, nil, payload, &block)
    end

    def get_spam_report(email:, &block)
      endpoint = SendGrid4r::REST::SpamReports.url(email)
      params = {}
      params['email'] = email
      resp = get(@auth, endpoint, params, &block)
      SendGrid4r::REST::SpamReports.create_spam_reports(resp)
    end

    def delete_spam_report(email:, &block)
      endpoint = SendGrid4r::REST::SpamReports.url(email)
      params = {}
      params['email'] = email
      delete(@auth, endpoint, params, &block)
    end
  end
end
