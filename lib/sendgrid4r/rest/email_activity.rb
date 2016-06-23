# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 EmailActivity
  #
  module EmailActivity
    include Request

    #
    # SendGrid Web API v3 Event - AggregatedBy
    #
    module Event
      BOUNCES = 'bounces'
      CLICKS = 'clicks'
      DEFERRED = 'deferred'
      DELIVERED = 'delivered'
      DROPS = 'drops'
      GROUP_UNSUBSCRIBE = 'group_unsubscribe'
      GROUP_RESUBSCRIBE = 'group_resubscribe'
      OPENS = 'opens'
      PROCESSED = 'processed'
      PARSEAPI = 'parseapi'
      SPAM_REPORTS = 'spam_reports'
      UNSUBSCRIBE = 'unsubscribes'
    end

    Activity = Struct.new(
      :email, :event, :created, :category, :smtp_id, :asm_group_id,
      :msg_id, :ip, :url, :reason
    )

    def self.url
      "#{BASE_URL}/email_activity"
    end

    def self.create_activities(resp)
      return resp if resp.nil?
      resp.map { |activity| EmailActivity.create_activity(activity) }
    end

    def self.create_activity(resp)
      return resp if resp.nil?
      Activity.new(
        resp['email'],
        resp['event'],
        resp['created'].nil? ? nil : Time.at(resp['created']),
        resp['category'],
        resp['smtp_id'],
        resp['asm_group_id'],
        resp['msg_id'],
        resp['ip'],
        resp['url'],
        resp['reason']
      )
    end

    def get_email_activities(
      email: nil, events: nil, exclude_events: nil, start_time: nil,
      end_time: nil, &block
    )
      params = {}
      params['email'] = email unless email.nil?
      params['events'] = events unless events.nil?
      params['exclude_events'] = exclude_events unless exclude_events.nil?
      params['start_time'] = start_time.to_i unless start_time.nil?
      params['end_time'] = end_time.to_i unless end_time.nil?
      resp = get(@auth, EmailActivity.url, params, &block)
      finish(resp, @raw_resp) { |r| EmailActivity.create_activities(r) }
    end
  end
end
