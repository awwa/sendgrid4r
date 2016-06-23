# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Sm
    #
    # SendGrid Web API v3 Suppression Management - Suppressions
    #
    module Suppressions
      include Request

      Suppression = Struct.new(:id, :name, :description, :suppressed)
      Suppressions = Struct.new(:suppressions)

      def self.url(group_id, email_address = nil)
        url = "#{BASE_URL}/asm/groups/#{group_id}/suppressions"
        url = "#{url}/#{email_address}" unless email_address.nil?
        url
      end

      def self.create_suppressions(resp)
        return resp if resp.nil?
        suppressions = resp['suppressions'].map do |suppression|
          Sm::Suppressions.create_suppression(suppression)
        end
        Suppressions.new(suppressions)
      end

      def self.create_suppression(resp)
        return resp if resp.nil?
        Suppression.new(
          resp['id'], resp['name'], resp['description'], resp['suppressed']
        )
      end

      def post_suppressed_emails(group_id:, recipient_emails:, &block)
        resp = post(
          @auth,
          Sm::Suppressions.url(group_id),
          recipient_emails: recipient_emails,
          &block
        )
        finish(resp, @raw_resp) { |r| Sm.create_recipient_emails(r) }
      end

      def get_suppressed_emails(group_id:, &block)
        endpoint = Sm::Suppressions.url(group_id)
        resp = get(@auth, endpoint, &block)
        finish(resp, @raw_resp) { |r| r }
      end

      def get_suppressions(email_address:, &block)
        endpoint = "#{BASE_URL}/asm/suppressions/#{email_address}"
        resp = get(@auth, endpoint, &block)
        finish(resp, @raw_resp) do |r|
          Sm::Suppressions.create_suppressions(r)
        end
      end

      def delete_suppressed_email(group_id:, email_address:, &block)
        delete(
          @auth,
          Sm::Suppressions.url(group_id, email_address),
          &block
        )
      end
    end
  end
end
