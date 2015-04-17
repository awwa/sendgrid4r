# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

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
        url = "#{SendGrid4r::Client::BASE_URL}/templates"
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

      def post_template(name, &block)
        resp = post(@auth, SendGrid4r::REST::Templates.url, name: name, &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def get_templates(&block)
        resp = get(@auth, SendGrid4r::REST::Templates.url, &block)
        SendGrid4r::REST::Templates.create_templates(resp)
      end

      def get_template(temp_id, &block)
        resp = get(@auth, SendGrid4r::REST::Templates.url(temp_id), &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def patch_template(temp_id, name, &block)
        resp = patch(
          @auth, SendGrid4r::REST::Templates.url(temp_id), name: name, &block)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def delete_template(temp_id, &block)
        delete(@auth, SendGrid4r::REST::Templates.url(temp_id), &block)
      end
    end
  end
end
