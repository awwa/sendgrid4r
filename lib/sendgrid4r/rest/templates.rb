# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"
require "versions"

module SendGrid4r
  module REST

    Template = Struct.new(:id, :name, :versions)

    module Templates

      include SendGrid4r::REST::Request

      def self.create_template(resp)
        vers = Array.new
        resp["versions"].each{|ver|
          vers.push(SendGrid4r::REST::Templates::create_version(ver))
        }
        Template.new(resp["id"], resp["name"], vers)
      end

      def get_templates
        resp_a = get(@auth, "#{SendGrid4r::Client::BASE_URL}/templates")
        tmps = Array.new
        resp_a["templates"].each{|resp|
          tmps.push(SendGrid4r::REST::Templates::create_template(resp))
        }
        tmps
      end

      def get_template(template_id)
        resp = get(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}")
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def post_template(name)
        resp = post(@auth, "#{SendGrid4r::Client::BASE_URL}/templates", { "name" => name })
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def patch_template(template_id, name)
        resp = patch(
          @auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}", { "name" => name })
        SendGrid4r::REST::Templates.create_template(resp)
      end

      def delete_template(template_id)
        delete(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}")
      end

    end
  end
end
