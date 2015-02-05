# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Asm

      Group = Struct.new(:id, :name, :description, :last_email_sent_at, :unsubscribes)

      def self.create_group(resp)
        Group.new(
          resp["id"],
          resp["name"],
          resp["description"],
          resp["last_email_sent_at"],
          resp["unsubscribes"]
        )
      end

      module Groups

        include SendGrid4r::REST::Request

        def get_groups
          resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups")
          groups = Array.new
          resp_a.each{|resp|
            groups.push(SendGrid4r::REST::Asm::create_group(resp))
          }
          groups
        end

        def get_group(group_id)
          resp = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}")
          SendGrid4r::REST::Asm::create_group(resp)
        end

        def post_group(name, description)
          params = {"name" => name, "description" => description}
          resp = post(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups", params)
          SendGrid4r::REST::Asm::create_group(resp)
        end

        def patch_group(group_id, group)
          resp = patch(
            @auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}", group.to_h)
          SendGrid4r::REST::Asm::create_group(resp)
        end

        def delete_group(group_id)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}")
        end

      end
    end
  end
end
