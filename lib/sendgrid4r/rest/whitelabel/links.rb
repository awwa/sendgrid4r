# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Whitelabel
  #
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Links
    #
    module Links
      include Request

      Link = Struct.new(
        :id, :domain, :subdomain, :username, :user_id, :default,
        :valid, :legacy, :dns
      )
      Dns = Struct.new(:domain_cname, :owner_cname)
      Record = Struct.new(:host, :type, :data, :valid)

      def self.url(id = nil)
        url = "#{BASE_URL}/whitelabel/links"
        url = "#{url}/#{id}" unless id.nil?
        url
      end

      def self.create_links(resp)
        return resp if resp.nil?
        resp.map { |link| Links.create_link(link) }
      end

      def self.create_link(resp)
        return resp if resp.nil?
        Link.new(
          resp['id'],
          resp['domain'],
          resp['subdomain'],
          resp['username'],
          resp['user_id'],
          resp['default'],
          resp['valid'],
          resp['legacy'],
          Links.create_dns(resp['dns'])
        )
      end

      def self.create_dns(resp)
        return resp if resp.nil?
        Dns.new(
          Links.create_record(resp['domain_cname']),
          Links.create_record(resp['owner_cname'])
        )
      end

      def self.create_record(resp)
        return resp if resp.nil?
        Record.new(resp['host'], resp['type'], resp['data'], resp['valid'])
      end

      Result = Struct.new(:id, :valid, :validation_results)
      ValidationResults = Struct.new(:domain_cname, :owner_cname)
      ValidationResult = Struct.new(:valid, :reason)

      def self.create_result(resp)
        return resp if resp.nil?
        Result.new(
          resp['id'],
          resp['valid'],
          Links.create_validation_results(resp['validation_results'])
        )
      end

      def self.create_validation_results(resp)
        return resp if resp.nil?
        ValidationResults.new(
          Links.create_validation_result(resp['domain_cname']),
          Links.create_validation_result(resp['owner_cname'])
        )
      end

      def self.create_validation_result(resp)
        return resp if resp.nil?
        ValidationResult.new(resp['valid'], resp['reason'])
      end

      def get_wl_links(
        limit: nil, offset: nil, exclude_subusers: nil, username: nil,
        domain: nil, &block
      )
        params = {}
        params[:limit] = limit unless limit.nil?
        params[:offset] = offset unless offset.nil?
        unless exclude_subusers.nil?
          params[:exclude_subusers] = exclude_subusers
        end
        params[:username] = username unless username.nil?
        params[:domain] = domain unless domain.nil?
        resp = get(@auth, Links.url, params, &block)
        finish(resp, @raw_resp) { |r| Links.create_links(r) }
      end

      def post_wl_link(subdomain:, domain:, default: nil, &block)
        params = {
          subdomain: subdomain,
          domain: domain
        }
        params[:default] = default unless default.nil?
        resp = post(@auth, Links.url, params, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end

      def get_wl_link(id:, &block)
        resp = get(@auth, Links.url(id), nil, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end

      def patch_wl_link(id:, default:, &block)
        params = { default: default }
        resp = patch(@auth, Links.url(id), params, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end

      def delete_wl_link(id:, &block)
        delete(@auth, Links.url(id), &block)
      end

      def get_default_wl_link(domain: nil, &block)
        params = {}
        params[:domain] = domain unless domain.nil?
        resp = get(@auth, "#{Links.url}/default", params, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end

      def validate_wl_link(id:, &block)
        resp = post(@auth, "#{Links.url(id)}/validate", &block)
        finish(resp, @raw_resp) { |r| Links.create_result(r) }
      end

      def get_associated_wl_link(username:, &block)
        params = { username: username }
        resp = get(@auth, "#{Links.url}/subuser", params, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end

      def disassociate_wl_link(username:, &block)
        params = { username: username }
        delete(@auth, "#{Links.url}/subuser", params, &block)
      end

      def associate_wl_link(id:, username:, &block)
        params = { username: username }
        resp = post(@auth, "#{Links.url(id)}/subuser", params, &block)
        finish(resp, @raw_resp) { |r| Links.create_link(r) }
      end
    end
  end
end
