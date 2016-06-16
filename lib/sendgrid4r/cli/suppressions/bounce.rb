module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions Bounce
    #
    class Bounce < SgThor
      desc 'list', 'List bounces'
      option :start_time, type: :numeric
      option :end_time, type: :numeric
      def list
        puts @client.get_bounces(
          start_time: options[:start_time], end_time: options[:end_time]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete bounces'
      option :delete_all, type: :boolean
      option :email
      option :emails, type: :array
      def delete
        if options[:email]
          puts @client.delete_bounce(email: options[:email])
        else
          puts @client.delete_bounces(
            delete_all: options[:delete_all], emails: options[:emails]
          )
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a bounce'
      option :email, require: true
      def get
        puts @client.get_bounce(email: options[:email])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
