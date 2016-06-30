module SendGrid4r::CLI
  module Webhooks
    #
    # SendGrid Web API v3 Webhook Parse
    #
    class Parse < SgThor
      desc 'list', 'List parse webhook settings'
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_parse_settings(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create a parse webhook setting'
      option :hostname, require: true
      option :url, require: true
      option :spam_check, type: :boolean, require: true
      option :send_raw, type: :boolean, require: true
      def create
        puts @client.post_parse_setting(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a parse webhook setting'
      option :hostname
      def get
        puts @client.get_parse_setting(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a parse webhook setting'
      option :hostname, require: true
      option :url
      option :spam_check, type: :boolean
      option :send_raw, type: :boolean
      def update
        puts @client.patch_parse_setting(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a parse webhook setting'
      option :hostname, require: true
      def delete
        puts @client.delete_parse_setting(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
