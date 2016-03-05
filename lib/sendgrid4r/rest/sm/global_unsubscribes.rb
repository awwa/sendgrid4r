# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    module Sm
      #
      # SendGrid Web API v3 Suppression Management - Global Unsubscribes
      #
      module GlobalSuppressions
        include SendGrid4r::REST::Request

        Suppression = Struct.new(:created, :email)

        def self.url(email_address = nil)
          url = "#{BASE_URL}/asm/suppressions/global"
          url = "#{url}/#{email_address}" unless email_address.nil?
          url
        end

        def self.url_unsubscribes
          "#{BASE_URL}/suppression/unsubscribes"
        end

        def self.create_supressions(resp)
          return resp if resp.nil?
          suppressions = []
          resp.each do |suppression|
            created = Time.at(suppression['created'])
            suppressions.push(Suppression.new(created, suppression['email']))
          end
          suppressions
        end

        def get_global_unsubscribes(
          start_time: nil, end_time: nil, limit: nil, offset: nil, &block
        )
          params = {}
          params['start_time'] = start_time.to_i unless start_time.nil?
          params['end_time'] = end_time.to_i unless end_time.nil?
          params['limit'] = limit.to_i unless limit.nil?
          params['offset'] = offset.to_i unless offset.nil?
          endpoint = SendGrid4r::REST::Sm::GlobalSuppressions.url_unsubscribes
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Sm::GlobalSuppressions.create_supressions(resp)
        end

        def post_global_suppressed_emails(recipient_emails:, &block)
          params = { recipient_emails: recipient_emails }
          endpoint = SendGrid4r::REST::Sm::GlobalSuppressions.url
          resp = post(@auth, endpoint, params, &block)
          SendGrid4r::REST::Sm.create_recipient_emails(resp)
        end

        def get_global_suppressed_email(email_address:, &block)
          endpoint =
            SendGrid4r::REST::Sm::GlobalSuppressions.url(email_address)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Sm.create_recipient_email(resp)
        end

        def delete_global_suppressed_email(email_address:, &block)
          endpoint =
            SendGrid4r::REST::Sm::GlobalSuppressions.url(email_address)
          delete(@auth, endpoint, &block)
        end
      end
    end
  end
end
