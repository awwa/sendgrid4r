# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Sm
    #
    # SendGrid Web API v3 Suppression Management - Suppressions
    #
    module Suppressions
      include Request

      Group = Struct.new(
        :id, :name, :description, :suppressed, :is_default
      )
      Groups = Struct.new(:suppressions)

      def self.url(group_id, email_address = nil)
        url = "#{BASE_URL}/asm/groups/#{group_id}/suppressions"
        url = "#{url}/#{email_address}" unless email_address.nil?
        url
      end

      def self.create_groups(resp)
        return resp if resp.nil?
        suppressions = resp['suppressions'].map do |suppression|
          Sm::Suppressions.create_group(suppression)
        end
        Groups.new(suppressions)
      end

      def self.create_group(resp)
        return resp if resp.nil?
        Group.new(
          resp['id'],
          resp['name'],
          resp['description'],
          resp['suppressed'],
          resp['is_default']
        )
      end

      Suppression = Struct.new(
        :email, :group_id, :group_name, :created_at
      )

      def self.suppressions_url(email = nil)
        url = "#{BASE_URL}/asm/suppressions"
        url = "#{url}/#{email}" unless email.nil?
        url
      end

      def self.create_suppression(resp)
        return resp if resp.nil?
        created_at = Time.at(resp['created_at'])
        Suppression.new(
          resp['email'],
          resp['group_id'],
          resp['group_name'],
          created_at
        )
      end

      def get_suppressions(&block)
        endpoint = Sm::Suppressions.suppressions_url
        resp = get(@auth, endpoint, &block)
        finish(resp, @raw_resp) do |r|
          r.map do |suppression|
            Sm::Suppressions.create_suppression(suppression)
          end
        end
      end

      def get_groups_by_email(email_address:, &block)
        endpoint = Sm::Suppressions.suppressions_url(email_address)
        resp = get(@auth, endpoint, &block)
        finish(resp, @raw_resp) do |r|
          Sm::Suppressions.create_groups(r)
        end
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

      def delete_suppressed_email(group_id:, email_address:, &block)
        delete(
          @auth,
          Sm::Suppressions.url(group_id, email_address),
          &block
        )
      end

      def search_suppressed_emails(group_id:, recipient_emails:, &block)
        resp = post(
          @auth,
          Sm::Suppressions.url(group_id, :search),
          recipient_emails: recipient_emails,
          &block
        )
        finish(resp, @raw_resp) { |r| r }
      end
    end
  end
end
