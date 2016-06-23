# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Campaign Factory Class implementation
    #
    class CampaignFactory
      def create(title: nil, subject: nil, sender_id: nil, list_ids: nil,
        segment_ids: nil, categories: nil, suppression_group_id: nil,
        custom_unsubscribe_url: nil, ip_pool: nil, html_content: nil,
        plain_content: nil)
        campaign = REST::MarketingCampaigns::Campaign.new(
          nil, title, subject, sender_id, list_ids, segment_ids, categories,
          suppression_group_id, custom_unsubscribe_url, ip_pool, html_content,
          plain_content, nil, nil
        )
        campaign.to_h.reject { |_key, value| value.nil? }
      end

      def create_sender(
        nickname:, from:, reply_to:, address:, address_2:, city:, state:,
        zip:, country:
      )
        REST::MarketingCampaigns::Sender.new(
          nil, nickname, nil, nil, address, address_2,
          city, state, zip, country, nil, nil, nil, nil
        ).tap do |sender|
          sender.from = from
          sender.reply_to = reply_to
        end
      end

      def create_address(email:, name:)
        REST::MarketingCampaigns::Address.new(email, name).to_h
      end
    end
  end
end
