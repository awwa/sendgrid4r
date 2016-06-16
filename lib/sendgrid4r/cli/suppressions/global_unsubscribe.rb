module SendGrid4r::CLI
  module Suppressions
    class GlobalUnsubscribe < SgThor

      desc 'list', 'List global unsubscribes'
      option :start_time, :type => :numeric
      option :end_time, :type => :numeric
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_global_unsubscribes(
          start_time: options[:start_time], end_time: options[:end_time],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'add', 'Add email addresses to the Global Unsubscribes'
      option :emails, :type => :array, :require => true
      def add
        puts @client.post_global_unsubscribes(
          recipient_emails: options[:emails]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete global unsubscribes'
      option :email, :require => true
      def delete
        puts @client.delete_global_unsubscribe(
          email_address: options[:email]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a global unsubscribe'
      option :email, :require => true
      def get
        puts @client.get_global_unsubscribe(email_address: options[:email])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
