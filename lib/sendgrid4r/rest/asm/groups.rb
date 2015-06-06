# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    module Asm
      #
      # SendGrid Web API v3 Advanced Suppression Manager - Groups
      #
      module Groups
        include SendGrid4r::REST::Request

        Group = Struct.new(
          :id, :name, :description, :last_email_sent_at, :unsubscribes)

        def self.url(group_id = nil)
          url = "#{BASE_URL}/asm/groups"
          url = "#{url}/#{group_id}" unless group_id.nil?
          url
        end

        def self.create_groups(resp)
          return resp if resp.nil?
          groups = []
          resp.each do |group|
            groups.push(SendGrid4r::REST::Asm::Groups.create_group(group))
          end
          groups
        end

        def self.create_group(resp)
          return resp if resp.nil?
          Group.new(
            resp['id'],
            resp['name'],
            resp['description'],
            resp['last_email_sent_at'],
            resp['unsubscribes']
          )
        end

        def post_group(name:, description:, &block)
          params = { name: name, description: description }
          resp = post(@auth, SendGrid4r::REST::Asm::Groups.url, params, &block)
          SendGrid4r::REST::Asm::Groups.create_group(resp)
        end

        def get_groups(&block)
          resp = get(@auth, SendGrid4r::REST::Asm::Groups.url, &block)
          SendGrid4r::REST::Asm::Groups.create_groups(resp)
        end

        def get_group(group_id:, &block)
          resp = get(@auth, SendGrid4r::REST::Asm::Groups.url(group_id), &block)
          SendGrid4r::REST::Asm::Groups.create_group(resp)
        end

        def patch_group(group_id:, group:, &block)
          endpoint = SendGrid4r::REST::Asm::Groups.url(group_id)
          resp = patch(@auth, endpoint, group.to_h, &block)
          SendGrid4r::REST::Asm::Groups.create_group(resp)
        end

        def delete_group(group_id:, &block)
          delete(@auth, SendGrid4r::REST::Asm::Groups.url(group_id), &block)
        end
      end
    end
  end
end
