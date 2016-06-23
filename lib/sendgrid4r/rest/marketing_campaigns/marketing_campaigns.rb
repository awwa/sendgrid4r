# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 MarketingCampaigns
  #
  module MarketingCampaigns
    include Request

    Campaign = Struct.new(
      :id, :title, :subject, :sender_id, :list_ids, :segment_ids,
      :categories, :suppression_group_id, :custom_unsubscribe_url,
      :ip_pool, :html_content, :plain_content, :send_at, :status
    )

    Campaigns = Struct.new(:result)

    def self.create_campaign(resp)
      return resp if resp.nil?
      send_at = Time.at(resp['send_at']) unless resp['send_at'].nil?
      Campaign.new(
        resp['id'], resp['title'], resp['subject'], resp['sender_id'],
        resp['list_ids'], resp['segment_ids'], resp['categories'],
        resp['suppression_group_id'], resp['custom_unsubscribe_url'],
        resp['ip_pool'], resp['html_content'], resp['plain_content'],
        send_at, resp['status']
      )
    end

    def self.create_campaigns(resp)
      return resp if resp.nil?
      result = resp['result'].map do |campaign|
        MarketingCampaigns.create_campaign(campaign)
      end
      Campaigns.new(result)
    end

    def self.url(campaign_id = nil)
      url = "#{BASE_URL}/campaigns"
      url = "#{url}/#{campaign_id}" unless campaign_id.nil?
      url
    end

    def post_campaign(params:, &block)
      endpoint = MarketingCampaigns.url
      resp = post(@auth, endpoint, params, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def get_campaigns(&block)
      endpoint = MarketingCampaigns.url
      resp = get(@auth, endpoint, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaigns(r) }
    end

    def get_campaign(campaign_id:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      resp = get(@auth, endpoint, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def delete_campaign(campaign_id:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      delete(@auth, endpoint, &block)
    end

    def patch_campaign(campaign_id:, params:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      resp = patch(@auth, endpoint, params.to_h, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def send_campaign(campaign_id:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules/now"
      resp = post(@auth, endpoint, nil, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def schedule_campaign(campaign_id:, send_at:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules"
      payload = {}
      payload['send_at'] = send_at.to_i
      resp = post(@auth, endpoint, payload, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def reschedule_campaign(campaign_id:, send_at:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules"
      payload = {}
      payload['send_at'] = send_at.to_i
      resp = patch(@auth, endpoint, payload, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def get_schedule_time_campaign(campaign_id:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules"
      resp = get(@auth, endpoint, &block)
      finish(resp, @raw_resp) { |r| MarketingCampaigns.create_campaign(r) }
    end

    def unschedule_campaign(campaign_id:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules"
      delete(@auth, endpoint, &block)
    end

    def test_campaign(campaign_id:, to:, &block)
      endpoint = MarketingCampaigns.url(campaign_id)
      endpoint = "#{endpoint}/schedules/test"
      payload = {}
      payload['to'] = to
      post(@auth, endpoint, payload, &block)
    end
  end
end
