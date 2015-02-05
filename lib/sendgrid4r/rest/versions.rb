# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Templates

      Version = Struct.new(
        :id, :template_id, :active, :name, :html_content,
        :plain_content, :subject, :updated_at)

      def self.create_version(resp)
        Version.new(
          resp["id"],
          resp["template_id"],
          resp["active"],
          resp["name"],
          resp["html_content"],
          resp["plain_content"],
          resp["subject"],
          resp["updated_at"])
      end

      module Versions

        include SendGrid4r::REST::Request

        def get_version(template_id, version_id)
          resp = get(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}")
          SendGrid4r::REST::Templates::create_version(resp)
        end

        def post_version(template_id, version)
          resp = post(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions",
            remove_uneditable_keys(version.to_h)
          )
          SendGrid4r::REST::Templates::create_version(resp)
        end

        def activate_version(template_id, version_id)
          resp = post(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}/activate"
          )
          SendGrid4r::REST::Templates::create_version(resp)
        end

        def patch_version(template_id, version_id, version)
          resp = patch(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}",
            remove_uneditable_keys(version.to_h)
          )
          SendGrid4r::REST::Templates::create_version(resp)
        end

        def delete_version(template_id, version_id)
          delete(
            @auth,
            "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}/versions/#{version_id}"
          )
        end

        private
        def remove_uneditable_keys(hash_value)
          hash_value.delete(:id) if hash_value.has_key?(:id)
          hash_value.delete(:template_id) if hash_value.has_key?(:template_id)
          return hash_value
        end
      end

    end
  end
end
