module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions SpamReport
    #
    class SpamReport < SgThor
      desc 'list', 'List spam reports'
      option :start_time, type: :numeric
      option :end_time, type: :numeric
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_spam_reports(
          start_time: options[:start_time], end_time: options[:end_time],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete spam reports'
      option :delete_all, type: :boolean
      option :email
      option :emails, type: :array
      def delete
        if options[:email]
          @client.delete_spam_report(email: options[:email])
        else
          @client.delete_spam_reports(
            delete_all: options[:delete_all], emails: options[:emails]
          )
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a spam report'
      option :email, require: true
      def get
        puts @client.get_spam_report(email: options[:email])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
