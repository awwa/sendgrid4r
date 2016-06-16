module SendGrid4r::CLI
  module Whitelabel
    #
    # SendGrid Web API v3 Whitelabel Link
    #
    class Link < SgThor
      desc 'list', 'List all Link whitelabels'
      option :limit
      option :offset
      option :exclude_subusers
      option :username
      option :domain
      def list
        puts @client.get_wl_links(
          limit: options[:limit], offset: options[:offset],
          exclude_subusers: options[:exclude_subusers],
          username: options[:username], domain: options[:domain]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create a link whitelabel'
      option :domain, require: true
      option :subdomain, require: true
      option :default, type: :boolean
      def create
        puts @client.post_wl_link(
          domain: options[:domain],
          subdomain: options[:subdomain],
          default: options[:default]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Retrieve a link whitelabel'
      option :id, require: true
      def get
        puts @client.get_wl_link(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a link whitelabel'
      option :id, require: true
      option :default, type: :boolean, require: true
      def update
        puts @client.patch_wl_link(
          id: options[:id], default: options[:default]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a link whitelabel'
      option :id, require: true
      def delete
        puts @client.delete_wl_link(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'default', 'Default a link whitelabel'
      option :domain
      def default
        puts @client.get_default_wl_link(domain: options[:domain])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'validate', 'Validate a link whitelabel'
      option :id, require: true
      def validate
        puts @client.validate_wl_link(id: options[:id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list_associated', 'List Associated link'
      option :username, require: true
      def list_associated
        puts @client.get_associated_wl_link(username: options[:username])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'disassociate', 'Disassociate link'
      option :username, require: true
      def disassociate
        puts @client.disassociate_wl_link(username: options[:username])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'associate', 'Associate link'
      option :id, require: true
      option :username, require: true
      def associate
        puts @client.associate_wl_link(
          id: options[:id], username: options[:username]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
