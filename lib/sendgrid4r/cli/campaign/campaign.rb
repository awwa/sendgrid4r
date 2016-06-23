module SendGrid4r::CLI
  module Campaign
    #
    # SendGrid Web API v3 Marketing Campaigns
    #
    class Campaign < SgThor
      desc 'create', 'Create a campaign'
      option :title
      option :subject
      option :sender_id, type: :numeric
      option :list_ids, type: :array
      option :segment_ids, type: :array
      option :categories, type: :array
      option :suppression_group_id, type: :numeric
      option :html_content
      option :plain_content
      def create
        params = SendGrid4r::Factory::CampaignFactory.new.create(
          parameterise(options)
        )
        res = @client.post_campaign(params: params)
        puts URI.decode(JSON.load(res).to_s)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'list', 'List campaigns'
      def list
        res = @client.get_campaigns
        puts URI.decode(JSON.load(res).to_s)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'get', 'Get a campaign'
      option :campaign_id, type: :numeric, require: true
      def get
        res = @client.get_campaign(parameterise(options))
        puts URI.decode(JSON.load(res).to_s)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'delete', 'Delete a campaign'
      option :campaign_id, type: :numeric, require: true
      def delete
        puts @client.delete_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'update', 'Update a campaign'
      option :campaign_id, type: :numeric, require: true
      option :title
      option :subject
      option :sender_id, type: :numeric
      option :list_ids, type: :array
      option :categories, type: :array
      option :suppression_group_id, type: :numeric
      option :html_content
      option :plain_content
      def update
        factory = SendGrid4r::Factory::CampaignFactory.new
        params = parameterise(options)
        params.delete(:campaign_id)
        campaign = factory.create(params)
        res = @client.patch_campaign(
          campaign_id: options[:campaign_id],
          params: campaign
        )
        puts URI.decode(JSON.load(res).to_s)
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'send', 'Send a campaign'
      option :campaign_id, type: :numeric, require: true
      def send
        puts @client.send_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'schedule', 'Schedule a campaign'
      option :campaign_id, type: :numeric, require: true
      option :send_at, type: :numeric, require: true
      def schedule
        puts @client.schedule_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'reschedule', 'Reschedule a campaign'
      option :campaign_id, type: :numeric, require: true
      option :send_at, type: :numeric, require: true
      def reschedule
        puts @client.reschedule_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'unschedule', 'Unschedule a campaign'
      option :campaign_id, type: :numeric, require: true
      def unschedule
        puts @client.unschedule_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'time', 'View scheduled time of a campaign'
      option :campaign_id, type: :numeric, require: true
      def time
        puts @client.get_schedule_time_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc 'test', 'Send a test campaign'
      option :campaign_id, type: :numeric, require: true
      option :to, require: true
      def test
        puts @client.test_campaign(parameterise(options))
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
      end

      desc('sender SUBCOMMAND ...ARGS', 'Manage senders')
      subcommand('sender', Sender)

      desc('contact SUBCOMMAND ...ARGS', 'Manage contacts')
      subcommand('contact', Contact::Contact)
    end
  end
end
