# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 EmailActivity
    #
    module EmailActivity
      include SendGrid4r::REST::Request

      Activity = Struct.new(
        :email, :event, :created, :category, :smtp_id, :asm_group_id,
        :msg_id, :ip, :url, :reason
      )

      def self.url
        url = "#{BASE_URL}/email_activity"
        url
      end

      def self.create_activities(resp)
        return resp if resp.nil?
        activities = []
        resp.each do |activity|
          activities.push(
            SendGrid4r::REST::EmailActivity.create_activity(activity)
          )
        end
        activities
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
        resp = get(@auth, SendGrid4r::REST::EmailActivity.url, params, &block)
        SendGrid4r::REST::EmailActivity.create_activities(resp)
      end
    end
  end
end
