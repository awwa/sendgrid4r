module SendGrid4r::CLI
  module Campaign
    #
    # SendGrid Web API v3 Marketing Campaigns - Sender
    #
    class Sender < SgThor
      def initialize(*args)
        super
        @factory = SendGrid4r::Factory::CampaignFactory.new
      end
      desc 'create', 'Create a sender'
      option :nickname
      option :from, type: :hash
      option :reply_to, type: :hash
      option :address
      option :address_2
      option :city
      option :state
      option :zip
      option :country
      def create
        sender = @factory.create_sender(parameterise(options))
        puts @client.post_sender(params: sender)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List senders'
      def list
        puts @client.get_senders
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a sender'
      option :sender_id, type: :numeric, require: true
      option :nickname
      option :from, type: :hash
      option :reply_to, type: :hash
      option :address
      option :address_2
      option :city
      option :state
      option :zip
      option :country
      def update
        params = parameterise(options)
        params.delete(:sender_id)
        sender = @factory.create_sender(params)
        puts @client.patch_sender(
          sender_id: options[:sender_id],
          params: sender
        )
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a sender'
      option :sender_id, type: :numeric, require: true
      def delete
        puts @client.delete_sender(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'verify', 'Resend sender identity verification'
      option :sender_id, type: :numeric, require: true
      def verify
        puts @client.resend_sender_verification(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a sender'
      option :sender_id, type: :numeric, require: true
      def get
        puts @client.get_sender(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
    end
  end
end
