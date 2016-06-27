# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Alerts
  #
  module Alerts
    include Request

    Alert = Struct.new(
      :created_at,
      :email_to,
      :frequency,
      :id,
      :percentage,
      :type,
      :updated_at
    )

    def self.url(alert_id = nil)
      url = "#{BASE_URL}/alerts"
      url = "#{url}/#{alert_id}" unless alert_id.nil?
      url
    end

    def self.create_alerts(resp)
      return resp if resp.nil?
      resp.map { |alert| Alerts.create_alert(alert) }
    end

    def self.create_alert(resp)
      return resp if resp.nil?
      created_at = Time.at(resp['created_at'])
      updated_at = Time.at(resp['updated_at'])
      Alert.new(
        created_at,
        resp['email_to'],
        resp['frequency'],
        resp['id'],
        resp['percentage'],
        resp['type'],
        updated_at
      )
    end

    def get_alerts(&block)
      resp = get(@auth, Alerts.url, &block)
      finish(resp, @raw_resp) { |r| Alerts.create_alerts(r) }
    end

    def post_alert(type:, email_to:, percentage: nil, frequency: nil, &block)
      params = { type: type, email_to: email_to }
      params[:percentage] = percentage unless percentage.nil?
      params[:frequency] = frequency unless frequency.nil?
      resp = post(@auth, Alerts.url, params, &block)
      finish(resp, @raw_resp) { |r| Alerts.create_alert(r) }
    end

    def get_alert(alert_id:, &block)
      endpoint = Alerts.url(alert_id)
      resp = get(@auth, endpoint, &block)
      finish(resp, @raw_resp) { |r| Alerts.create_alert(r) }
    end

    def delete_alert(alert_id:, &block)
      delete(@auth, Alerts.url(alert_id), &block)
    end

    def patch_alert(
      alert_id:, email_to: nil, frequency: nil, percentage: nil, &block
    )
      params = {}
      params[:email_to] = email_to unless email_to.nil?
      params[:frequency] = frequency unless frequency.nil?
      params[:percentage] = percentage unless percentage.nil?
      endpoint = Alerts.url(alert_id)
      resp = patch(@auth, endpoint, params, &block)
      finish(resp, @raw_resp) { |r| Alerts.create_alert(r) }
    end
  end
end
