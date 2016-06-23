# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  module MarketingCampaigns
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Segments
      #
      module Segments
        include Request

        Condition = Struct.new(:field, :value, :operator, :and_or)
        Segment = Struct.new(
          :id, :name, :list_id, :conditions, :recipient_count
        )
        Segments = Struct.new(:segments)

        def self.url(segment_id = nil)
          url = "#{BASE_URL}/contactdb/segments"
          url = "#{url}/#{segment_id}" unless segment_id.nil?
          url
        end

        def self.create_condition(resp)
          return resp if resp.nil?
          Condition.new(
            resp['field'], resp['value'], resp['operator'], resp['and_or']
          )
        end

        def self.create_segment(resp)
          return resp if resp.nil?
          conditions = resp['conditions'].map do |condition|
            Contacts::Segments.create_condition(condition)
          end
          Segment.new(
            resp['id'],
            resp['name'],
            resp['list_id'],
            conditions,
            resp['recipient_count']
          )
        end

        def self.create_segments(resp)
          return resp if resp.nil?
          segments = resp['segments'].map do |segment|
            Contacts::Segments.create_segment(segment)
          end
          Segments.new(segments)
        end

        def post_segment(params:, &block)
          resp = post(@auth, Contacts::Segments.url, params.to_h, &block)
          finish(resp, @raw_resp) { |r| Contacts::Segments.create_segment(r) }
        end

        def get_segments(&block)
          resp = get(@auth, Contacts::Segments.url, &block)
          finish(resp, @raw_resp) { |r| Contacts::Segments.create_segments(r) }
        end

        def get_segment(segment_id:, &block)
          resp = get(@auth, Contacts::Segments.url(segment_id), &block)
          finish(resp, @raw_resp) { |r| Contacts::Segments.create_segment(r) }
        end

        def patch_segment(segment_id:, params:, &block)
          endpoint = Contacts::Segments.url(segment_id)
          resp = patch(@auth, endpoint, params, &block)
          finish(resp, @raw_resp) { |r| Contacts::Segments.create_segment(r) }
        end

        def delete_segment(segment_id:, &block)
          delete(@auth, Contacts::Segments.url(segment_id), &block)
        end

        def get_recipients_on_segment(segment_id:, &block)
          endpoint = "#{Contacts::Segments.url(segment_id)}/recipients"
          resp = get(@auth, endpoint, nil, &block)
          finish(resp, @raw_resp) do |r|
            Contacts::Recipients.create_recipients(r)
          end
        end
      end
    end
  end
end
