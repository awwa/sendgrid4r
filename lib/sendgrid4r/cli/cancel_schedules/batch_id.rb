module SendGrid4r::CLI
  module CancelSchedules
    class BatchId < SgThor

      desc 'generate', 'Generate Batch ID'
      def generate_batch_id
        puts @client.generate_batch_id
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'validate', 'Validate Batch ID'
      option :batch_id, :require => true
      def validate_batch_id
        puts @client.validate_batch_id(batch_id: options[:batch_id])
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
