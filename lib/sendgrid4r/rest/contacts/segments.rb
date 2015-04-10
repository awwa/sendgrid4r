# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/request'

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
          url = "#{SendGrid4r::Client::BASE_URL}/contactdb/segments"
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

        def post_segment(params, &block)
          resp = post(
            @auth, SendGrid4r::REST::Contacts::Segments.url, params.to_h, &block
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def get_segments(&block)
          resp = get(@auth, SendGrid4r::REST::Contacts::Segments.url, &block)
          SendGrid4r::REST::Contacts::Segments.create_segments(resp)
        end

        def get_segment(segment_id, &block)
          resp = get(
            @auth, SendGrid4r::REST::Contacts::Segments.url(segment_id), &block
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def put_segment(segment_id, params, &block)
          resp = put(
            @auth,
            SendGrid4r::REST::Contacts::Segments.url(segment_id),
            params,
            &block
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def delete_segment(segment_id, &block)
          delete(
            @auth, SendGrid4r::REST::Contacts::Segments.url(segment_id), &block
          )
        end

        def get_recipients_from_segment(
          segment_id, limit = nil, offset = nil, &block
        )
          params = {}
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless offset.nil?
          url = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          resp = get(@auth, "#{url}/recipients", params, &block)
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end
      end
    end
  end
end
