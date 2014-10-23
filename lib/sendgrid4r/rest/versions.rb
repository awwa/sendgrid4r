# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Templates
      module Versions

        include SendGrid4r::REST::Request

        def get_version(template_id, version_id)
          Version.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}"))
        end

        def post_version(template_id, version)
          Version.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions", version.to_hash))
        end

        def activate_version(template_id, version_id)
          Version.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}/activate"))
        end

        def patch_version(template_id, version_id, version)
          Version.create(patch(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}", version.to_hash))
        end

        def delete_version(template_id, version_id)
          delete(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}")
        end
      end

      class Version

        attr_accessor :id, :template_id, :active, :name, :html_content, :plain_content, :subject, :updated_at

        def self.create(value)
          obj = Version.new
          obj.id = value["id"]
          obj.template_id = value["template_id"]
          obj.active = value["active"]
          obj.name = value["name"]
          obj.html_content = value["html_content"]
          obj.plain_content = value["plain_content"]
          obj.subject = value["subject"]
          obj.updated_at = value["updated_at"]
          obj
        end

        def to_hash
          hash = {
            "active" => @active,
            "name" => @name,
            "html_content" => @html_content,
            "plain_content" => @plain_content,
            "subject" => @subject,
          }
          hash
        end

      end
    end
  end
end
