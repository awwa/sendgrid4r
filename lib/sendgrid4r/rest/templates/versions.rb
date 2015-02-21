# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Template Engine - Templates
    #
    module Templates
      Version = Struct.new(
        :id, :template_id, :active, :name, :html_content,
        :plain_content, :subject, :updated_at)

      def self.create_version(resp)
        Version.new(
          resp['id'],
          resp['template_id'],
          resp['active'],
          resp['name'],
          resp['html_content'],
          resp['plain_content'],
          resp['subject'],
          resp['updated_at'])
      end

      #
      # SendGrid Web API v3 Template Engine - Versions
      #
      module Versions
        include SendGrid4r::REST::Request

        def self.url(temp_id, ver_id = nil)
          url = "#{SendGrid4r::Client::BASE_URL}/templates/#{temp_id}/versions"
          url = "#{url}/#{ver_id}" unless ver_id.nil?
          url
        end

        def get_version(temp_id, ver_id)
          resp = get(
            @auth,
            "#{SendGrid4r::REST::Templates::Versions.url(temp_id, ver_id)}")
          SendGrid4r::REST::Templates.create_version(resp)
        end

        def post_version(temp_id, version)
          resp = post(
            @auth,
            "#{SendGrid4r::REST::Templates::Versions.url(temp_id)}",
            remove_uneditable_keys(version.to_h)
          )
          SendGrid4r::REST::Templates.create_version(resp)
        end

        def activate_version(temp_id, ver_id)
          url = SendGrid4r::REST::Templates::Versions.url(temp_id, ver_id)
          resp = post(
            @auth,
            "#{url}/activate"
          )
          SendGrid4r::REST::Templates.create_version(resp)
        end

        def patch_version(temp_id, ver_id, version)
          resp = patch(
            @auth,
            "#{SendGrid4r::REST::Templates::Versions.url(temp_id, ver_id)}",
            remove_uneditable_keys(version.to_h)
          )
          SendGrid4r::REST::Templates.create_version(resp)
        end

        def delete_version(temp_id, ver_id)
          delete(
            @auth,
            "#{SendGrid4r::REST::Templates::Versions.url(temp_id, ver_id)}"
          )
        end

        private

        def remove_uneditable_keys(hash_value)
          hash_value.delete(:id) if hash_value.key?(:id)
          hash_value.delete(:template_id) if hash_value.key?(:template_id)
          hash_value
        end
      end
    end
  end
end
