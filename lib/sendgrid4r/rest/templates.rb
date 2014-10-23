# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

require "versions"

module SendGrid4r
  module REST
    module Templates

      include SendGrid4r::REST::Request

      def get_templates
        response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/templates")
        tmps = Array.new
        response["templates"].each{|template|
          tmp = Template.create(template)
          tmps.push(tmp)
        } if response["templates"] != nil
        tmps
      end

      def get_template(template_id)
        Template.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}"))
      end

      def post_template(name)
        params = Hash.new
        params["name"] = name
        Template.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/templates", params))
      end

      def patch_template(template_id, name)
        params = Hash.new
        params["name"] = name
        Template.create(patch(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}", params))
      end

      def delete_template(template_id)
        delete(@auth, "#{SendGrid4r::Client::BASE_URL}/templates/#{template_id}")
      end

    end

    class Template

      attr_accessor :id, :name, :versions

      def self.create(value)
        obj = Template.new
        obj.id = value["id"]
        obj.name = value["name"]
        obj.versions = []
        value["versions"].each{|version|
          ver = Templates::Version.create(version)
          obj.versions.push(ver)
        }
        obj
      end

    end
  end
end
