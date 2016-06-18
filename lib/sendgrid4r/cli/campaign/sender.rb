module SendGrid4r::CLI
  module Campaign
    #
    # SendGrid Web API v3 Marketing Campaigns
    #
    class Sender < SgThor
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
        factory = SendGrid4r::Factory::CampaignFactory.new
        # from = factory.create_address(
        #   email: options[:from_email], name: options[:from_name]
        # )
        # reply_to = factory.create_address(
        #   email: options[:reply_to_email], name: options[:reply_to_name]
        # )
        params = factory.create(
          parameterise(options)
        )
        puts @client.post_campaign(params: params)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end
      #
      # desc 'list', 'List campaigns'
      # def list
      #   puts @client.get_campaigns
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'get', 'Get a campaign'
      # option :campaign_id
      # def get
      #   puts @client.get_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'delete', 'Delete a campaign'
      # option :campaign_id
      # def delete
      #   puts @client.delete_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'update', 'Update a campaign'
      # option :campaign_id
      # option :title
      # option :subject
      # option :sender_id
      # option :list_ids
      # option :categories
      # option :suppression_group_id
      # option :html_content
      # option :plain_content
      # def update
      #   factory = SendGrid4r::Factory::CampaignFactory.new
      #   params = parameterise(options)
      #   params.delete(:campaign_id)
      #   campaign = factory.create(params)
      #   puts @client.patch_campaign(
      #     campaign_id: options[:campaign_id],
      #     params: campaign
      #   )
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'send', 'Send a campaign'
      # option :campaign_id
      # def send
      #   puts @client.send_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'schedule', 'Schedule a campaign'
      # option :campaign_id
      # option :send_at
      # def schedule
      #   puts @client.schedule_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'reschedule', 'Reschedule a campaign'
      # option :campaign_id
      # option :send_at
      # def reschedule
      #   puts @client.reschedule_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'unschedule', 'Unschedule a campaign'
      # option :campaign_id
      # def unschedule
      #   puts @client.unschedule_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # desc 'test', 'Send a test campaign'
      # option :campaign_id
      # option :to
      # def test
      #   puts @client.test_campaign(parameterise(options))
      # rescue RestClient::ExceptionWithResponse => e
      #   puts e.inspect
      # end
      #
      # # desc('sender SUBCOMMAND ...ARGS', 'Manage sender')
      # # subcommand('sender', Sender)
      # #
      # # desc('contact SUBCOMMAND ...ARGS', 'Manage contact')
      # # subcommand('contact', Contact)
    end
  end
end
