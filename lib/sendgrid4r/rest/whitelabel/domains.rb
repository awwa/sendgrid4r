# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Whitelabel
    #
    module Whitelabel
      #
      # SendGrid Web API v3 Whitelabel Domains
      #
      module Domains
        include SendGrid4r::REST::Request

        Domain = Struct.new(:id, :domain, :subdomain, :username,
          :user_id, :ips, :custom_spf, :default, :legacy,
          :automatic_security, :valid, :dns
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
          domains = []
          resp.each do |domain|
            domains.push(
              SendGrid4r::REST::Whitelabel::Domains.create_domain(domain)
            )
          end
          domains
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
            SendGrid4r::REST::Whitelabel::Domains.create_dns(resp['dns'])
          )
        end

        def self.create_dns(resp)
          return resp if resp.nil?
          Dns.new(
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['mail_cname']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['dkim1']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['dkim2']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['mail_server']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['subdomain_spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['domain_spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_record(
              resp['dkim']
            )
          )
        end

        def self.create_record(resp)
          return resp if resp.nil?
          Record.new(resp['host'], resp['type'], resp['data'], resp['valid'])
        end

        Result = Struct.new(:id, :valid, :validation_results)
        ValidationResults = Struct.new(
          # automatic_security:true
          :mail_cname, :spf, :dkim1, :dkim2,
          # automatic_security:false
          :mail_server, :subdomain_spf, :domain_spf, :dkim
        )
        ValidationResult = Struct.new(:valid, :reason)

        def self.create_result(resp)
          return resp if resp.nil?
          Result.new(
            resp['id'],
            resp['valid'],
            SendGrid4r::REST::Whitelabel::Domains.create_validation_results(
              resp['validation_results']
            )
          )
        end

        def self.create_validation_results(resp)
          return resp if resp.nil?
          ValidationResults.new(
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['mail_cname']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['dkim1']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['dkim2']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['mail_server']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['subdomain_spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['domain_spf']
            ),
            SendGrid4r::REST::Whitelabel::Domains.create_validation_result(
              resp['dkim']
            )
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
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless offset.nil?
          unless exclude_subusers.nil?
            params['exclude_subusers'] = exclude_subusers
          end
          params['username'] = username unless username.nil?
          params['domain'] = domain unless domain.nil?
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domains(resp)
        end

        def post_wl_domain(
          domain:, subdomain:, username: nil, ips: nil, automatic_security: nil,
          custom_spf: nil, default: nil, &block
        )
          params = {}
          params['domain'] = domain
          params['subdomain'] = subdomain
          params['username'] = username unless username.nil?
          params['ips'] = ips unless ips.nil?
          unless automatic_security.nil?
            params['automatic_security'] = automatic_security
          end
          params['custom_spf'] = custom_spf unless custom_spf.nil?
          params['default'] = default unless default.nil?
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url
          resp = post(@auth, endpoint, params, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def get_wl_domain(id:, &block)
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
          resp = get(@auth, endpoint, nil, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def patch_wl_domain(
          id:, domain: nil, subdomain: nil, username: nil, ips: nil,
          automatic_security: nil, custom_spf: nil, default: nil, &block
        )
          params = {}
          params['domain'] = domain unless domain.nil?
          params['subdomain'] = subdomain unless subdomain.nil?
          params['username'] = username unless username.nil?
          params['ips'] = ips unless ips.nil?
          unless automatic_security.nil?
            params['automatic_security'] = automatic_security
          end
          params['custom_spf'] = custom_spf unless custom_spf.nil?
          params['default'] = default unless default.nil?
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
          resp = patch(@auth, endpoint, params, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def delete_wl_domain(id:, &block)
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
          delete(@auth, endpoint, &block)
        end

        def get_default_wl_domain(domain: nil, &block)
          params = {}
          params['domain'] = domain unless domain.nil?
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url
          endpoint = "#{endpoint}/default"
          resp = get(@auth, endpoint, params, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def add_ip_to_wl_domain(id:, ip:, &block)
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
          endpoint = "#{endpoint}/ips"
          params = {}
          params['ip'] = ip
          resp = post(@auth, endpoint, params, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def remove_ip_from_wl_domain(id:, ip:, &block)
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id, ip)
          resp = delete(@auth, endpoint, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        end

        def validate_wl_domain(id:, &block)
          endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
          endpoint = "#{endpoint}/validate"
          resp = post(@auth, endpoint, &block)
          SendGrid4r::REST::Whitelabel::Domains.create_result(resp)
        end

        # def get_associated_domain(username:, &block)
        #   endpoint = SendGrid4r::REST::Whitelabel::Domains.url
        #   endpoint = "#{endpoint}/subuser"
        #   params = {}
        #   params['username'] = username
        #   resp = get(@auth, endpoint, params, &block)
        #   SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        # end
        #
        # def disassociate_domain(id:, username:, &block)
        #   endpoint = SendGrid4r::REST::Whitelabel::Domains.url
        #   endpoint = "#{endpoint}/subuser"
        #   params = {}
        #   params['username'] = username
        #   delete(@auth, endpoint, params, &block)
        # end
        #
        # def associate_domain(id:, username:, &block)
        #   endpoint = SendGrid4r::REST::Whitelabel::Domains.url(id)
        #   endpoint = "#{endpoint}/subuser"
        #   params = {}
        #   params['username'] = username
        #   resp = post(@auth, endpoint, params, &block)
        #   SendGrid4r::REST::Whitelabel::Domains.create_domain(resp)
        # end
      end
    end
  end
end
