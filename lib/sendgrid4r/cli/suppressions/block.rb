module SendGrid4r::CLI
  module Suppressions
    #
    # SendGrid Web API v3 Suppressions Block
    #
    class Block < SgThor
      desc 'list', 'List blocks'
      option :start_time, type: :numeric
      option :end_time, type: :numeric
      option :limit, type: :numeric
      option :offset, type: :numeric
      def list
        puts @client.get_blocks(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete blocks'
      option :delete_all, type: :boolean
      option :email
      option :emails, type: :array
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
      option :email, require: true
      def get
        puts @client.get_block(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
