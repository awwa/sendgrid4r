# -*- encoding: utf-8 -*-

module SendGrid4r
  module Factory
    #
    # SendGrid Web API v3 Condition Factory Class implementation
    #
    class ConditionFactory
      def create(field:, value:, operator:, and_or:)
        SendGrid4r::REST::MarketingCampaigns::Contacts::Segments::Condition.new(
          field,
          value,
          operator,
          and_or
        ).to_h
      end
    end
  end
end
