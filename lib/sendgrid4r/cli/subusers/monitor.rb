module SendGrid4r::CLI
  module Subusers
    #
    # SendGrid Web API v3 Subusers Monitor
    #
    class Monitor < SgThor
      desc 'list', 'Retrieve monitor settings'
      option :username, require: true
      def list
        puts @client.get_subuser_monitor(
          username: options[:username]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'create', 'Create monitor settings'
      option :username, require: true
      option :email, require: true
      option :frequency, type: :numeric, require: true
      def create
        puts @client.post_subuser_monitor(
          username: options[:username], email: options[:email],
          frequency: options[:frequency]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update monitor settings'
      option :username, require: true
      option :email, require: true
      option :frequency, type: :numeric, require: true
      def update
        puts @client.put_subuser_monitor(
          username: options[:username], email: options[:email],
          frequency: options[:frequency]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete monitor settings'
      option :username, require: true
      def delete
        puts @client.delete_subuser_monitor(
          username: options[:username]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
