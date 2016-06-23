module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions GroupUnsubscribe
    #
    class GroupUnsubscribe < SgThor
      desc 'add', 'Add email addresses to the group supressions'
      option :group_id, require: true
      option :recipient_emails, type: :array, require: true
      def add
        puts @client.post_suppressed_emails(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List suppressed addresses for a given group'
      option :group_id, require: true
      def list
        puts @client.get_suppressed_emails(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'remove', 'Remove an email address from the given group'
      option :group_id, require: true
      option :email_address, require: true
      def remove
        @client.delete_suppressed_email(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
