module SendGrid4r::CLI
  module CancelSchedules
    class CancelSchedule < SgThor

      desc 'add', 'Cancel shceduled sends'
      option :batch_id, :require => true
      option :status, :require => true
      def add
        puts @client.post_scheduled_send(
          batch_id: options[:batch_id], status: options[:status]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'Get all cancel/paused scheduled send information'
      def list
        puts @client.get_scheduled_sends
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a single cancel/paused scheduled send information'
      option :batch_id, :require => true
      def get
        puts @client.get_scheduled_sends(batch_id: options[:batch_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update the status of a scheduled send'
      option :batch_id, :require => true
      option :status, :require => true
      def update
        puts @client.patch_scheduled_send(
          batch_id: options[:batch_id], status: options[:status]
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete the cancel/pause of a scheduled send'
      option :batch_id, :require => true
      def delete
        puts @client.delete_scheduled_send(batch_id: options[:batch_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('batch_id SUBCOMMAND ...ARGS', 'Manage batch ID for canceling schedule sends')
      subcommand('batch_id', BatchId)
    end
  end
end
