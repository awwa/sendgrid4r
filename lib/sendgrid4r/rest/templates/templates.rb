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

      Template = Struct.new(:id, :name, :versions)

      def self.url(temp_id = nil)
        url = "#{SendGrid4r::Client::BASE_URL}/templates"
        url = "#{url}/#{temp_id}" unless temp_id.nil?
        url
      end

      def self.create_template(resp)
        vers = []
        resp['versions'].each do |ver|
          vers.push(SendGrid4r::REST::Templates.create_version(ver))
        end
        Template.new(resp['id'], resp['name'], vers)
      end

      def post_template(name)
        resp = post(@auth, SendGrid4r::REST::Templates.url, 'name' => name)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def get_templates
        resp_a = get(@auth, SendGrid4r::REST::Templates.url)
        tmps = []
        resp_a['templates'].each do |resp|
          tmps.push(SendGrid4r::REST::Templates.create_template(resp))
        end
        tmps
      end

      def get_template(temp_id)
        resp = get(@auth, SendGrid4r::REST::Templates.url(temp_id))
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def patch_template(temp_id, name)
        resp = patch(
          @auth, SendGrid4r::REST::Templates.url(temp_id), 'name' => name)
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def delete_template(temp_id)
        delete(@auth, SendGrid4r::REST::Templates.url(temp_id))
      end
    end
  end
end
