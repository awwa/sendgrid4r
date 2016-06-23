# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Template Engine - Templates
  #
  module TransactionalTemplates
    include Request

    Templates = Struct.new(:templates)
    Template = Struct.new(:id, :name, :versions)

    def self.url(temp_id = nil)
      url = "#{BASE_URL}/templates"
      url = "#{url}/#{temp_id}" unless temp_id.nil?
      url
    end

    def self.create_templates(resp)
      return resp if resp.nil?
      tmps = resp['templates'].map do |template|
        TransactionalTemplates.create_template(template)
      end
      Templates.new(tmps)
    end

    def self.create_template(resp)
      return resp if resp.nil?
      vers = resp['versions'].map do |ver|
        TransactionalTemplates::Versions.create_version(ver)
      end
      Template.new(resp['id'], resp['name'], vers)
    end

    def post_template(name:, &block)
      endpoint = TransactionalTemplates.url
      resp = post(@auth, endpoint, name: name, &block)
      finish(resp, @raw_resp) do |r|
        TransactionalTemplates.create_template(r)
      end
    end

    def get_templates(&block)
      resp = get(@auth, TransactionalTemplates.url, &block)
      finish(resp, @raw_resp) do |r|
        TransactionalTemplates.create_templates(r)
      end
    end

    def get_template(template_id:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      resp = get(@auth, endpoint, &block)
      finish(resp, @raw_resp) do |r|
        TransactionalTemplates.create_template(r)
      end
    end

    def patch_template(template_id:, name:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      resp = patch(@auth, endpoint, name: name, &block)
      finish(resp, @raw_resp) do |r|
        TransactionalTemplates.create_template(r)
      end
    end

    def delete_template(template_id:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      delete(@auth, endpoint, &block)
    end
  end
end
