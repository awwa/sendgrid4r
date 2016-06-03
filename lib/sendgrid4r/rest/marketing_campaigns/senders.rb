# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 MarketingCampaigns
  #
  module MarketingCampaigns
    include Request

    Sender = Struct.new(
      :id, :nickname, :from, :reply_to, :address, :address_2, :city, :state,
      :zip, :country, :verified, :updated_at, :created_at, :locked
    ) do
      def from=(from)
        tap { |s| s[:from] = from.to_h }
      end

      def reply_to=(reply_to)
        tap { |s| s[:reply_to] = reply_to.to_h }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end

    Address = Struct.new(:email, :name)

    Verified = Struct.new(:status, :reason)

    def self.create_sender(resp)
      return resp if resp.nil?
      from = MarketingCampaigns.create_address(resp['from'])
      reply_to = MarketingCampaigns.create_address(resp['reply_to'])
      verified = MarketingCampaigns.create_verified(resp['verified'])
      Sender.new(
        resp['id'], resp['nickname'], from, reply_to, resp['address'],
        resp['address_2'], resp['city'], resp['state'], resp['zip'],
        resp['country'], verified, Time.at(resp['updated_at']),
        Time.at(resp['created_at']), resp['locked']
      )
    end

    def self.create_senders(resp)
      return resp if resp.nil?
      resp.map do |sender|
        MarketingCampaigns.create_sender(sender)
      end
    end

    def self.create_address(resp)
      return resp if resp.nil?
      Address.new(resp['email'], resp['name'])
    end

    def self.create_verified(resp)
      return resp if resp.nil?
      Verified.new(resp['status'], resp['reason'])
    end

    def self.url_sender(sender_id = nil)
      url = "#{BASE_URL}/senders"
      url = "#{url}/#{sender_id}" unless sender_id.nil?
      url
    end

    def post_sender(params:, &block)
      endpoint = MarketingCampaigns.url_sender
      resp = post(@auth, endpoint, params.to_h, &block)
      MarketingCampaigns.create_sender(resp)
    end

    def get_senders(&block)
      endpoint = MarketingCampaigns.url_sender
      resp = get(@auth, endpoint, &block)
      MarketingCampaigns.create_senders(resp)
    end

    def patch_sender(sender_id:, params:, &block)
      endpoint = MarketingCampaigns.url_sender(sender_id)
      resp = patch(@auth, endpoint, params.to_h, &block)
      MarketingCampaigns.create_sender(resp)
    end

    def delete_sender(sender_id:, &block)
      endpoint = MarketingCampaigns.url_sender(sender_id)
      delete(@auth, endpoint, &block)
    end

    def resend_sender_verification(sender_id:, &block)
      endpoint = MarketingCampaigns.url_sender(sender_id)
      post(@auth, "#{endpoint}/resend_verification", nil, &block)
    end

    def get_sender(sender_id:, &block)
      endpoint = MarketingCampaigns.url_sender(sender_id)
      resp = get(@auth, endpoint, &block)
      MarketingCampaigns.create_sender(resp)
    end
  end
end
