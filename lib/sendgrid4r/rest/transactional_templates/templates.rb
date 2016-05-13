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
      tmps = []
      resp['templates'].each do |template|
        tmps.push(TransactionalTemplates.create_template(template))
      end
      Templates.new(tmps)
    end

    def self.create_template(resp)
      return resp if resp.nil?
      vers = []
      resp['versions'].each do |ver|
        vers.push(TransactionalTemplates::Versions.create_version(ver))
      end
      Template.new(resp['id'], resp['name'], vers)
    end

    def post_template(name:, &block)
      endpoint = TransactionalTemplates.url
      resp = post(@auth, endpoint, name: name, &block)
      TransactionalTemplates.create_template(resp)
    end

    def get_templates(&block)
      resp = get(@auth, TransactionalTemplates.url, &block)
      TransactionalTemplates.create_templates(resp)
    end

    def get_template(template_id:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      resp = get(@auth, endpoint, &block)
      TransactionalTemplates.create_template(resp)
    end

    def patch_template(template_id:, name:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      payload = {}
      payload['name'] = name
      resp = patch(@auth, endpoint, name: name, &block)
      TransactionalTemplates.create_template(resp)
    end

    def delete_template(template_id:, &block)
      endpoint = TransactionalTemplates.url(template_id)
      delete(@auth, endpoint, &block)
    end
  end
end
