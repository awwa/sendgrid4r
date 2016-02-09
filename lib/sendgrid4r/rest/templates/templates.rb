# -*- encoding: utf-8 -*-

require 'sendgrid4r/rest/request'
require 'versions'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Template Engine - Templates
    #
    module Templates
      include SendGrid4r::REST::Request

      Templates = Struct.new(:templates)
      Template = Struct.new(:id, :name, :versions)

      def self.url(temp_id = nil)
        url = "#{BASE_URL}/templates"
        url = "#{url}/#{temp_id}" unless temp_id.nil?
        url
      end

      def self.create_templates(resp)
        return resp if resp.nil?
        tmps = []
        resp['templates'].each do |template|
          tmps.push(SendGrid4r::REST::Templates.create_template(template))
        end
        Templates.new(tmps)
      end

      def self.create_template(resp)
        return resp if resp.nil?
        vers = []
        resp['versions'].each do |ver|
          vers.push(SendGrid4r::REST::Templates::Versions.create_version(ver))
        end
        Template.new(resp['id'], resp['name'], vers)
      end

      def post_template(name:, &block)
        endpoint = SendGrid4r::REST::Templates.url
        resp = post(@auth, endpoint, name: name, &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def get_templates(&block)
        resp = get(@auth, SendGrid4r::REST::Templates.url, &block)
        SendGrid4r::REST::Templates.create_templates(resp)
      end

      def get_template(template_id:, &block)
        endpoint = SendGrid4r::REST::Templates.url(template_id)
        resp = get(@auth, endpoint, &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def patch_template(template_id:, name:, &block)
        endpoint = SendGrid4r::REST::Templates.url(template_id)
        payload = {}
        payload['name'] = name
        resp = patch(@auth, endpoint, name: name, &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def delete_template(template_id:, &block)
        endpoint = SendGrid4r::REST::Templates.url(template_id)
        delete(@auth, endpoint, &block)
      end
    end
  end
end
