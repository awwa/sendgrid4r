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

        Segments = Struct.new(:segments)
        Segment = Struct.new(
          :id, :name, :list_id, :conditions, :recipient_count
        )

        Condition = Struct.new(
          :field, :value, :operator, :and_or
        )

        def self.url(segment_id = nil)
          url = "#{SendGrid4r::Client::BASE_URL}/contactdb/segments"
          url = "#{url}/#{segment_id}" unless segment_id.nil?
          url
        end

        def self.create_segments(resp)
          segments = []
          resp['segments'].each do |segment|
            segments.push(
              SendGrid4r::REST::Contacts::Segments.create_segment(segment)
            )
          end
          Segments.new(segments)
        end

        def self.create_segment(resp)
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

        def self.create_condition(resp)
          Condition.new(
            resp['field'], resp['value'], resp['operator'], resp['and_or']
          )
        end

        def post_segment(params)
          resp = post(
            @auth, SendGrid4r::REST::Contacts::Segments.url, params.to_h
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def get_segments
          resp = get(@auth, SendGrid4r::REST::Contacts::Segments.url)
          SendGrid4r::REST::Contacts::Segments.create_segments(resp)
        end

        def get_segment(segment_id)
          resp = get(
            @auth, SendGrid4r::REST::Contacts::Segments.url(segment_id)
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def put_segment(segment_id, params)
          resp = put(
            @auth, SendGrid4r::REST::Contacts::Segments.url(segment_id), params
          )
          SendGrid4r::REST::Contacts::Segments.create_segment(resp)
        end

        def delete_segment(segment_id)
          delete(@auth, SendGrid4r::REST::Contacts::Segments.url(segment_id))
        end

        def get_recipients_from_segment(segment_id, limit = nil, offset = nil)
          params = {}
          params['limit'] = limit unless limit.nil?
          params['offset'] = offset unless offset.nil?
          url = SendGrid4r::REST::Contacts::Segments.url(segment_id)
          resp = get(@auth, "#{url}/recipients", params)
          SendGrid4r::REST::Contacts::Recipients.create_recipients(resp)
        end
      end
    end
  end
end
