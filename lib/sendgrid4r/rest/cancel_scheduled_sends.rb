# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 CancelScheduledSends
  #
  module CancelScheduledSends
    include Request

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
      resp.map do |scheduled_send|
        CancelScheduledSends.create_scheduled_send(scheduled_send)
      end
    end

    def self.create_scheduled_send(resp)
      return resp if resp.nil?
      ScheduledSend.new(resp['batch_id'], resp['status'])
    end

    def generate_batch_id(&block)
      resp = post(@auth, CancelScheduledSends.batch_url, nil, &block)
      CancelScheduledSends.create_scheduled_send(resp)
    end

    def validate_batch_id(batch_id:, &block)
      resp = get(@auth, CancelScheduledSends.batch_url(batch_id), nil, &block)
      CancelScheduledSends.create_scheduled_send(resp)
    end

    def post_scheduled_send(batch_id:, status:, &block)
      endpoint = CancelScheduledSends.scheduled_sends_url
      payload = { batch_id: batch_id, status: status }
      resp = post(@auth, endpoint, payload, &block)
      CancelScheduledSends.create_scheduled_send(resp)
    end

    def get_scheduled_sends(batch_id: nil, &block)
      endpoint = CancelScheduledSends.scheduled_sends_url(batch_id)
      resp = get(@auth, endpoint, nil, nil, &block)
      CancelScheduledSends.create_scheduled_sends(resp)
    end

    def patch_scheduled_send(batch_id:, status:, &block)
      endpoint = CancelScheduledSends.scheduled_sends_url(batch_id)
      payload = { status: status }
      patch(@auth, endpoint, payload, &block)
    end

    def delete_scheduled_send(batch_id:, &block)
      endpoint = CancelScheduledSends.scheduled_sends_url(batch_id)
      delete(@auth, endpoint, nil, &block)
    end
  end
end
