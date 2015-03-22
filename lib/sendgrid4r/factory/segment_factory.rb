# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Segment Factory Class implementation
    #
    class SegmentFactory
      def create(name:, conditions:)
        SendGrid4r::REST::Contacts::Segments::Segment.new(
          nil,
          name,
          nil,
          conditions,
          nil
        ).to_h
      end
    end
  end
end
