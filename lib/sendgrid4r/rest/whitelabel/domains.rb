# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Whitelabel
  #
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Domains
    #
    module Domains
      include Request

      Domain = Struct.new(
        :id, :domain, :subdomain, :username, :user_id, :ips, :custom_spf,
        :default, :legacy, :automatic_security, :valid, :dns
      )
      Dns = Struct.new(
        # automatic_security:true
        :mail_cname, :spf, :dkim1, :dkim2,
        # automatic_security:false
        :mail_server, :subdomain_spf, :domain_spf, :dkim
      )
      Record = Struct.new(:host, :type, :data, :valid)

      def self.url(id = nil, ip = nil)
        url = "#{BASE_URL}/whitelabel/domains"
        url = "#{url}/#{id}" unless id.nil?
        url = "#{url}/ips/#{ip}" unless ip.nil?
        url
      end

      def self.create_domains(resp)
        return resp if resp.nil?
        resp.map { |domain| Domains.create_domain(domain) }
      end

      def self.create_domain(resp)
        return resp if resp.nil?
        Domain.new(
          resp['id'],
          resp['domain'],
          resp['subdomain'],
          resp['username'],
          resp['user_id'],
          resp['ips'],
          resp['custom_spf'],
          resp['default'],
          resp['legacy'],
          resp['automatic_security'],
          resp['valid'],
          Domains.create_dns(resp['dns'])
        )
      end

      def self.create_dns(resp)
        return resp if resp.nil?
        Dns.new(
          Domains.create_record(resp['mail_cname']),
          Domains.create_record(resp['spf']),
          Domains.create_record(resp['dkim1']),
          Domains.create_record(resp['dkim2']),
          Domains.create_record(resp['mail_server']),
          Domains.create_record(resp['subdomain_spf']),
          Domains.create_record(resp['domain_spf']),
          Domains.create_record(resp['dkim'])
        )
      end

      def self.create_record(resp)
        return resp if resp.nil?
        Record.new(resp['host'], resp['type'], resp['data'], resp['valid'])
      end

      Result = Struct.new(:id, :valid, :validation_results)
      ValidationResults = Struct.new(
        # automatic_security:true
        :mail_cname, :dkim1, :dkim2,
        # automatic_security:false
        :mail_server, :subdomain_spf, :dkim
      )
      ValidationResult = Struct.new(:valid, :reason)

      def self.create_result(resp)
        return resp if resp.nil?
        Result.new(
          resp['id'],
          resp['valid'],
          Domains.create_validation_results(resp['validation_results'])
        )
      end

      def self.create_validation_results(resp)
        return resp if resp.nil?
        ValidationResults.new(
          Domains.create_validation_result(resp['mail_cname']),
          Domains.create_validation_result(resp['dkim1']),
          Domains.create_validation_result(resp['dkim2']),
          Domains.create_validation_result(resp['mail_server']),
          Domains.create_validation_result(resp['subdomain_spf']),
          Domains.create_validation_result(resp['dkim'])
        )
      end

      def self.create_validation_result(resp)
        return resp if resp.nil?
        ValidationResult.new(resp['valid'], resp['reason'])
      end

      def get_wl_domains(
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
        resp = get(@auth, Domains.url, params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domains(r) }
      end

      def post_wl_domain(
        domain:, subdomain:, username: nil, ips: nil, automatic_security: nil,
        custom_spf: nil, default: nil, &block
      )
        params = {
          domain: domain,
          subdomain: subdomain
        }
        params[:username] = username unless username.nil?
        params[:ips] = ips unless ips.nil?
        unless automatic_security.nil?
          params[:automatic_security] = automatic_security
        end
        params[:custom_spf] = custom_spf unless custom_spf.nil?
        params[:default] = default unless default.nil?
        resp = post(@auth, Domains.url, params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def get_wl_domain(id:, &block)
        resp = get(@auth, Domains.url(id), nil, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def patch_wl_domain(id:, custom_spf: nil, default: nil, &block)
        params = {}
        params[:custom_spf] = custom_spf unless custom_spf.nil?
        params[:default] = default unless default.nil?
        resp = patch(@auth, Domains.url(id), params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def delete_wl_domain(id:, &block)
        delete(@auth, Domains.url(id), &block)
      end

      def get_default_wl_domain(domain: nil, &block)
        params = {}
        params[:domain] = domain unless domain.nil?
        resp = get(@auth, "#{Domains.url}/default", params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def add_ip_to_wl_domain(id:, ip:, &block)
        params = { ip: ip }
        resp = post(@auth, "#{Domains.url(id)}/ips", params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def remove_ip_from_wl_domain(id:, ip:, &block)
        resp = delete(@auth, Domains.url(id, ip), &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def validate_wl_domain(id:, &block)
        resp = post(@auth, "#{Domains.url(id)}/validate", &block)
        finish(resp, @raw_resp) { |r| Domains.create_result(r) }
      end

      def get_associated_wl_domain(username:, &block)
        params = { username: username }
        resp = get(@auth, "#{Domains.url}/subuser", params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end

      def disassociate_wl_domain(username:, &block)
        params = { username: username }
        delete(@auth, "#{Domains.url}/subuser", params, &block)
      end

      def associate_wl_domain(id:, username:, &block)
        endpoint = "#{Domains.url(id)}/subuser"
        params = { username: username }
        resp = post(@auth, endpoint, params, &block)
        finish(resp, @raw_resp) { |r| Domains.create_domain(r) }
      end
    end
  end
end
