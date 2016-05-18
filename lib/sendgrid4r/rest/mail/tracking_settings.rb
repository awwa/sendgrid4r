# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    TrackingSettings = Struct.new(
      :click_tracking, :open_tracking, :subscription_tracking,
      :ganalytics
    ) do
      def enable_click_tracking(enable_text)
        self.tap do |s|
          s[:click_tracking] = {enable: true, enable_text: enable_text}
        end
      end

      def disable_click_tracking
        self.tap { |s| s[:click_tracking] = {enable: false} }
      end

      def enable_open_tracking(substitution_tag)
        self.tap do |s|
          s[:open_tracking] = {
            enable: true,
            substitution_tag: substitution_tag
          }
        end
      end

      def disable_open_tracking
        self.tap { |s| s[:open_tracking] = { enable: false } }
      end

      def enable_subscription_tracking(text, html, substitution_tag)
        self.tap do |s|
          s[:subscription_tracking] = {
            enable: true,
            text: text,
            html: html,
            substitution_tag: substitution_tag
          }
        end
      end

      def disable_subscription_tracking
        self.tap { |s| s[:subscription_tracking] = { enable: false } }
      end

      def enable_ganalytics(
        utm_source, utm_medium, utm_term, utm_content, utm_campaign
      )
        self.tap do |s|
          s[:ganalytics] = {
            enable: true,
            utm_source: utm_source,
            utm_medium: utm_medium,
            utm_term: utm_term,
            utm_content: utm_content,
            utm_campaign: utm_campaign
          }
        end
      end

      def disable_ganalytics
        self.tap { |s| s[:ganalytics] = { enable: false } }
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
