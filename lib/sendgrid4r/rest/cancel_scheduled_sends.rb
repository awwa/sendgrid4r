# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 CancelScheduledSends
  #
  module CancelScheduledSends
    include SendGrid4r::REST::Request

    ScheduledSend = Struct.new(:batch_id, :status)

    def self.batch_url(batch_id = nil)
      url = "#{BASE_URL}/mail/batch"
      url = "#{url}/#{batch_id}" unless batch_id.nil?
      url
    end

    def self.scheduled_sends_url(batch_id = nil)
      url = "#{BASE_URL}/user/scheduled_sends"
      url = "#{url}/#{batch_id}" unless batch_id.nil?
      url
    end

    def self.create_scheduled_sends(resp)
      return resp if resp.nil?
      scheduled_sends = []
      resp.each do |scheduled_send|
        scheduled_sends.push(
          SendGrid4r::REST::CancelScheduledSends.create_scheduled_send(
            scheduled_send
          )
        )
      end
      scheduled_sends
    end

    def self.create_scheduled_send(resp)
      return resp if resp.nil?
      ScheduledSend.new(resp['batch_id'], resp['status'])
    end

    def generate_batch_id(&block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.batch_url
      resp = post(@auth, endpoint, nil, &block)
      SendGrid4r::REST::CancelScheduledSends.create_scheduled_send(resp)
    end

    def validate_batch_id(batch_id:, &block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.batch_url(batch_id)
      resp = get(@auth, endpoint, nil, &block)
      SendGrid4r::REST::CancelScheduledSends.create_scheduled_send(resp)
    end

    def post_scheduled_send(batch_id:, status:, &block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.scheduled_sends_url
      payload = {}
      payload['batch_id'] = batch_id
      payload['status'] = status
      resp = post(@auth, endpoint, payload, &block)
      SendGrid4r::REST::CancelScheduledSends.create_scheduled_send(resp)
    end

    def get_scheduled_sends(batch_id: nil, &block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.scheduled_sends_url(
        batch_id
      )
      resp = get(@auth, endpoint, nil, nil, &block)
      SendGrid4r::REST::CancelScheduledSends.create_scheduled_sends(resp)
    end

    def patch_scheduled_send(batch_id:, status:, &block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.scheduled_sends_url(
        batch_id
      )
      payload = {}
      payload['status'] = status
      patch(@auth, endpoint, payload, &block)
    end

    def delete_scheduled_send(batch_id:, &block)
      endpoint = SendGrid4r::REST::CancelScheduledSends.scheduled_sends_url(
        batch_id
      )
      delete(@auth, endpoint, nil, &block)
    end
  end
end
