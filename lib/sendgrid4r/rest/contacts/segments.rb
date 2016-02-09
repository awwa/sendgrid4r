# -*- encoding: utf-8 -*-


module SendGrid4r
  module REST
    module Contacts
      #
      # SendGrid Web API v3 Contacts - Segments
      #
      module Segments
        include SendGrid4r::REST::Request

        Condition = Struct.new(
          :field, :value, :operator, :and_or
        )
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
          conditions = []
          resp['conditions'].each do |condition|
            conditions.push(
              SendGrid4r::REST::Contacts::Segments.create_condition(condition)
            )
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
          segments = []
          resp['segments'].each do |segment|
            segments.push(
              SendGrid4r::REST::Contacts::Segments.create_segment(segment)
            )
          end
          Segments.new(segments)
        end

        def post_segment(params:, &block)
          endpoint = SendGrid4r::REST::Contacts::Segments.url
          resp = post(@auth, endpoint, params.to_h, &block)
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def get_segments(&block)
          resp = get(@auth, SendGrid4r::REST::Contacts::Segments.url, &block)
          SendGrid4r::REST::Contacts::Segments.create_segments(resp)
        end

        def get_segment(segment_id:, &block)
          endpoint = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          resp = get(@auth, endpoint, &block)
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def patch_segment(segment_id:, params:, &block)
          endpoint = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          resp = patch(@auth, endpoint, params, &block)
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def delete_segment(segment_id:, &block)
          endpoint = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          delete(@auth, endpoint, &block)
        end

        def get_recipients_on_segment(segment_id:, &block)
          url = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          resp = get(@auth, "#{url}/recipients", nil, &block)
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end
      end
    end
  end
end
