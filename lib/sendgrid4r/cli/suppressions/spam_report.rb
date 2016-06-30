module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions SpamReport
    #
    class SpamReport < SgThor
      desc 'list', 'List spam reports'
      option :start_time, banner: SgThor::UTS, type: :numeric
      option :end_time, banner: SgThor::UTS, type: :numeric
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_spam_reports(parameterise(options))
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
        puts @client.get_spam_report(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
