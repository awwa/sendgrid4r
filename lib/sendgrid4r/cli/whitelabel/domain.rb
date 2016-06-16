module SendGrid4r::CLI
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Domain
    #
    class Domain < SgThor
      desc 'list', 'List all Domain whitelabels'
      option :limit
      option :offset
      option :exclude_subusers
      option :username
      option :domain
      def list
        puts @client.get_wl_domains(
          limit: options[:limit], offset: options[:offset],
          exclude_subusers: options[:exclude_subusers],
          username: options[:username], domain: options[:domain]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create a domain whitelabel'
      option :domain, require: true
      option :subdomain, require: true
      option :automatic_security, type: :boolean
      option :custom_spf, type: :boolean
      option :default, type: :boolean
      def create
        puts @client.post_wl_domain(
          domain: options[:domain], subdomain: options[:subdomain],
          automatic_security: options[:automatic_security],
          custom_spf: options[:custom_spf], default: options[:default]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Retrieve a domain whitelabel'
      option :id, require: true
      def get
        puts @client.get_wl_domain(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a domain whitelabel'
      option :id, require: true
      option :custom_spf, type: :boolean
      option :default, type: :boolean
      def update
        puts @client.patch_wl_domain(
          id: options[:id], custom_spf: options[:custom_spf],
          default: options[:default]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a domain whitelabel'
      option :id, require: true
      def delete
        puts @client.delete_wl_domain(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'default', 'Default a domain'
      option :domain
      def default
        puts @client.get_default_wl_domain(domain: options[:domain])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'add_ip', 'Add an IP to a Domain'
      option :id, require: true
      option :ip, require: true
      def add_ip
        puts @client.add_ip_to_wl_domain(id: options[:id], ip: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'remove_ip', 'Remove an IP from a Domain'
      option :id, require: true
      option :ip, require: true
      def remove_ip
        puts @client.remove_ip_from_wl_domain(
          id: options[:id], ip: options[:id]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'validate', 'Validate a Domain'
      option :id, require: true
      def validate
        puts @client.validate_wl_domain(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list_associated', 'List Associated Domain'
      option :username, require: true
      def list_associated
        puts @client.get_associated_wl_domain(username: options[:username])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disassociate', 'Disassociate Domain'
      option :username, require: true
      def disassociate
        puts @client.disassociate_wl_domain(username: options[:username])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'associate', 'Associate Domain'
      option :id, require: true
      option :username, require: true
      def associate
        puts @client.associate_wl_domain(
          id: options[:id], username: options[:username]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
