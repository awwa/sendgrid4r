# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module Sm
    #
    # SendGrid Web API v3 Suppression Management - Groups
    #
    module Groups
      include Request

      Group = Struct.new(
        :id, :name, :description, :last_email_sent_at, :is_default,
        :unsubscribes
      )

      def self.url(group_id = nil)
        url = "#{BASE_URL}/asm/groups"
        url = "#{url}/#{group_id}" unless group_id.nil?
        url
      end

      def self.create_groups(resp)
        return resp if resp.nil?
        resp.map { |group| Sm::Groups.create_group(group) }
      end

      def self.create_group(resp)
        return resp if resp.nil?
        Group.new(
          resp['id'],
          resp['name'],
          resp['description'],
          resp['last_email_sent_at'],
          resp['is_default'],
          resp['unsubscribes']
        )
      end

      def post_group(name:, description:, is_default: nil, &block)
        params = { name: name, description: description }
        params[:is_default] = is_default unless is_default.nil?
        resp = post(@auth, Sm::Groups.url, params, &block)
        Sm::Groups.create_group(resp)
      end

      def get_groups(&block)
        resp = get(@auth, Sm::Groups.url, &block)
        Sm::Groups.create_groups(resp)
      end

      def get_group(group_id:, &block)
        resp = get(@auth, Sm::Groups.url(group_id), &block)
        Sm::Groups.create_group(resp)
      end

      def patch_group(group_id:, group:, &block)
        endpoint = Sm::Groups.url(group_id)
        resp = patch(@auth, endpoint, group.to_h, &block)
        Sm::Groups.create_group(resp)
      end

      def delete_group(group_id:, &block)
        delete(@auth, Sm::Groups.url(group_id), &block)
      end
    end
  end
end
