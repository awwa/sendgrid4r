# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Segment Factory Class implementation
    #
    class SegmentFactory
      def create(name: nil, list_id: nil, conditions:)
        segment = SendGrid4r::REST::Contacts::Segments::Segment.new(
          nil,
          name,
          list_id,
          conditions,
          nil
        )
        hash = segment.to_h
        hash.delete(:id)
        hash.delete(:list_id) if list_id.nil?
        hash
      end
    end
  end
end
