module SendGrid4r::CLI
  module Suppressions
    class GroupUnsubscribe < SgThor

      desc 'add', 'Add email addresses to the group supressions'
      option :group_id, :require => true
      option :emails, :type => :array, :require => true
      def add
        puts @client.post_suppressed_emails(
          group_id: options[:group_id],
          recipient_emails: options[:emails]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List suppressed addresses for a given group'
      option :group_id, :require => true
      def list
        puts @client.get_suppressed_emails(group_id: options[:group_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'remove', 'Remove an email address from the given group'
      option :group_id, :require => true
      option :email, :require => true
      def remove
        @client.delete_suppressed_email(
          group_id: options[:group_id], email_address: options[:email]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
