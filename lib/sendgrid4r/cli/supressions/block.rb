module SendGrid4r::CLI
  module Supressions
    class Block < SgThor

      desc 'list', 'List blocks'
      option :start_time, :type => :numeric
      option :end_time, :type => :numeric
      option :limit, :type => :numeric
      option :offset, :type => :numeric
      def list
        puts @client.get_blocks(
          start_time: options[:start_time], end_time: options[:end_time],
          limit: options[:limit], offset: options[:offset]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete blocks'
      option :delete_all, :type => :boolean
      option :email
      option :emails, :type => :array
      def delete
        if options[:email]
          puts @client.delete_block(email: options[:email])
        else
          puts @client.delete_blocks(
            delete_all: options[:delete_all], emails: options[:emails]
          )
        end
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a block'
      option :email, :require => true
      def get
        puts @client.get_block(email: options[:email])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
