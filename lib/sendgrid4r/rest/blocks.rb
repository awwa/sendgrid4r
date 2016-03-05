# -*- encoding: utf-8 -*-

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3 Blocks
    #
    module Blocks
      include SendGrid4r::REST::Request

      Block = Struct.new(
        :created, :email, :reason, :status
      )

      def self.url(email = nil)
        url = "#{BASE_URL}/suppression/blocks"
        url = "#{url}/#{email}" unless email.nil?
        url
      end

      def self.create_blocks(resp)
        return resp if resp.nil?
        blocks = []
        resp.each do |block|
          blocks.push(SendGrid4r::REST::Blocks.create_block(block))
        end
        blocks
      end

      def self.create_block(resp)
        return resp if resp.nil?
        created = Time.at(resp['created']) unless resp['created'].nil?
        Block.new(
          created,
          resp['email'],
          resp['reason'],
          resp['status']
        )
      end

      def get_blocks(
        start_time: nil, end_time: nil, limit: nil, offset: nil, &block
      )
        params = {}
        params['start_time'] = start_time.to_i unless start_time.nil?
        params['end_time'] = end_time.to_i unless end_time.nil?
        params['limit'] = limit.to_i unless limit.nil?
        params['offset'] = offset.to_i unless offset.nil?
        resp = get(@auth, SendGrid4r::REST::Blocks.url, params, &block)
        SendGrid4r::REST::Blocks.create_blocks(resp)
      end

      def delete_blocks(delete_all: nil, emails: nil, &block)
        endpoint = SendGrid4r::REST::Blocks.url
        payload = {}
        if delete_all == true
          payload['delete_all'] = delete_all
        else
          payload['emails'] = emails
        end
        delete(@auth, endpoint, nil, payload, &block)
      end

      def get_block(email:, &block)
        endpoint = SendGrid4r::REST::Blocks.url(email)
        params = {}
        params['email'] = email
        resp = get(@auth, endpoint, params, &block)
        SendGrid4r::REST::Blocks.create_blocks(resp)
      end

      def delete_block(email:, &block)
        endpoint = SendGrid4r::REST::Blocks.url(email)
        params = {}
        params['email'] = email
        delete(@auth, endpoint, params, &block)
      end
    end
  end
end
