# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Asm
      module Groups

        include SendGrid4r::REST::Request

        def get_groups
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups")
          groups = Array.new
          response.each{|grp|
            group = Group.create(grp)
            groups.push(group)
          } if response.length != 0
          groups
        end

        def get_group(group_id)
          Group.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}"))
        end

        def post_group(name, description)
          params = Hash.new
          params["name"] = name
          params["description"] = description
          Group.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups", params))
        end

        def patch_group(group_id, group)
          Group.create(patch(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}", group.to_hash))
        end

        def delete_group(group_id)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/asm/groups/#{group_id}")
        end

      end

      class Group

        attr_accessor :id, :name, :description, :last_email_sent_at, :unsubscribes

        def self.create(value)
          obj = Group.new
          obj.id = value["id"]
          obj.name = value["name"]
          obj.description = value["description"]
          obj.last_email_sent_at = value["last_email_sent_at"]
          obj.unsubscribes = value["unsubscribes"]
          obj
        end

        def to_hash
          hash = {
            "name" => @name,
            "description" => @description,
          }
          hash
        end

      end

    end
  end
end
