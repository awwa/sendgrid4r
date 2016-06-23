# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Template Engine - Templates
  #
  module TransactionalTemplates
    #
    # SendGrid Web API v3 Template Engine - Versions
    #
    module Versions
      include Request

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
        resp = post(
          @auth,
          Versions.url(template_id),
          remove_uneditable_keys(version.to_h),
          &block
        )
        finish(resp, @raw_resp) { |r| Versions.create_version(r) }
      end

      def activate_version(template_id:, version_id:, &block)
        url = Versions.url(template_id, version_id)
        resp = post(@auth, "#{url}/activate", &block)
        finish(resp, @raw_resp) { |r| Versions.create_version(r) }
      end

      def get_version(template_id:, version_id:, &block)
        resp = get(
          @auth,
          Versions.url(template_id, version_id),
          &block
        )
        finish(resp, @raw_resp) { |r| Versions.create_version(r) }
      end

      def patch_version(template_id:, version_id:, version:, &block)
        resp = patch(
          @auth,
          Versions.url(template_id, version_id),
          remove_uneditable_keys(version.to_h),
          &block
        )
        finish(resp, @raw_resp) { |r| Versions.create_version(r) }
      end

      def delete_version(template_id:, version_id:, &block)
        delete(
          @auth,
          Versions.url(template_id, version_id),
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
