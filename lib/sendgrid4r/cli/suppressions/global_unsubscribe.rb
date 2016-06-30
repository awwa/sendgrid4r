module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions GlobalUnsubscribe
    #
    class GlobalUnsubscribe < SgThor
      desc 'list', 'List global unsubscribes'
      option :start_time, banner: SgThor::UTS, type: :numeric
      option :end_time, banner: SgThor::UTS, type: :numeric
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_global_unsubscribes(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'add', 'Add email addresses to the Global Unsubscribes'
      option :recipient_emails, type: :array, require: true
      def add
        puts @client.post_global_unsubscribes(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete global unsubscribes'
      option :email_address, require: true
      def delete
        puts @client.delete_global_unsubscribe(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a global unsubscribe'
      option :email_address, require: true
      def get
        puts @client.get_global_unsubscribe(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
