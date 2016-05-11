# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Template Engine - Templates
  #
  module Templates
    #
    # SendGrid Web API v3 Template Engine - Versions
    #
    module Versions
      include SendGrid4r::REST::Request

      Version = Struct.new(
        :id, :user_id, :template_id, :active, :name, :html_content,
        :plain_content, :subject, :updated_at)

      def self.create_version(resp)
        return resp if resp.nil?
        Version.new(
          resp['id'],
          resp['user_id'],
          resp['template_id'],
          resp['active'],
          resp['name'],
          resp['html_content'],
          resp['plain_content'],
          resp['subject'],
          resp['updated_at'])
      end

      def self.url(temp_id, ver_id = nil)
        url = "#{BASE_URL}/templates/#{temp_id}/versions"
        url = "#{url}/#{ver_id}" unless ver_id.nil?
        url
      end

      def post_version(template_id:, version:, &block)
        endpoint = SendGrid4r::REST::Templates::Versions.url(template_id)
        resp = post(
          @auth,
          endpoint,
          remove_uneditable_keys(version.to_h),
          &block
        )
        SendGrid4r::REST::Templates::Versions.create_version(resp)
      end

      def activate_version(template_id:, version_id:, &block)
        url = SendGrid4r::REST::Templates::Versions.url(
          template_id, version_id
        )
        resp = post(@auth, "#{url}/activate", &block)
        SendGrid4r::REST::Templates::Versions.create_version(resp)
      end

      def get_version(template_id:, version_id:, &block)
        resp = get(
          @auth,
          SendGrid4r::REST::Templates::Versions.url(template_id, version_id),
          &block
        )
        SendGrid4r::REST::Templates::Versions.create_version(resp)
      end

      def patch_version(template_id:, version_id:, version:, &block)
        resp = patch(
          @auth,
          SendGrid4r::REST::Templates::Versions.url(template_id, version_id),
          remove_uneditable_keys(version.to_h),
          &block
        )
        SendGrid4r::REST::Templates::Versions.create_version(resp)
      end

      def delete_version(template_id:, version_id:, &block)
        delete(
          @auth,
          SendGrid4r::REST::Templates::Versions.url(template_id, version_id),
          &block
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
