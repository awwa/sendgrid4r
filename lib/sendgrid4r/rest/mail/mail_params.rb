# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail

    Email = Struct.new(:email, :name) do
      def to_h
        super.reject { |key, value| value.nil? }
      end
    end

    Personalization = Struct.new(
      :to, :subject, :cc, :bcc, :headers, :substitutions, :custom_args, :send_at
    ) do
      def set_ccs(ccs)
        self[:cc] = ccs
        self
      end

      def set_bccs(bccs)
        self[:bcc] = bccs
        self
      end

      def set_headers(headers)
        self[:headers] = headers
        self
      end

      def set_substitutions(substitutions)
        self[:substitutions] = substitutions
        self
      end

      def set_custom_args(custom_args)
        self[:custom_args] = custom_args
        self
      end

      def set_send_at(send_at)
        self[:send_at] = send_at
        self
      end

      def to_h
        self[:to] = self[:to].map { |to| to.to_h }
        self[:cc] = self[:cc].map { |cc| cc.to_h } unless self[:cc].nil?
        self[:bcc] = self[:bcc].map { |bcc| bcc.to_h } unless self[:bcc].nil?
        self[:send_at] = self[:send_at].to_i if self[:send_at].class == Time
        super.reject { |key, value| value.nil? }
      end
    end

    Params = Struct.new(
      :personalizations, :from, :content, :reply_to, :attachments, :template_id,
      :sections, :headers, :categories, :custom_args, :send_at, :batch_id, :asm,
      :ip_pool_name, :mail_settings, :tracking_settings
    ) do
      def set_reply_to(reply_to)
        self[:reply_to] = reply_to
        self
      end

      def set_attachments(attachments)
        self[:attachments] = attachments
        self
      end

      def set_template_id(template_id)
        self[:template_id] = template_id
        self
      end

      def set_sections(sections)
        self[:sections] = sections
        self
      end

      def set_headers(headers)
        self[:headers] = headers
        self
      end

      def set_categories(categories)
        self[:categories] = categories
        self
      end

      def set_custom_args(custom_args)
        self[:custom_args] = custom_args
        self
      end

      def set_send_at(send_at)
        self[:send_at] = send_at
        self
      end

      def set_batch_id(batch_id)
        self[:batch_id] = batch_id
        self
      end

      def set_asm(group_id, groups_to_display = nil)
        self[:asm] = {}
        self[:asm]['group_id'] = group_id
        unless groups_to_display.nil?
          self[:asm]['groups_to_display'] = groups_to_display
        end
        self
      end

      def set_ip_pool_name(ip_pool_name)
        self[:ip_pool_name] = ip_pool_name
        self
      end

      def set_mail_settings(mail_settings)
        self[:mail_settings] = mail_settings
        self
      end

      def set_tracking_settings(tracking_settings)
        self[:tracking_settings] = tracking_settings
        self
      end

      def to_h
        self[:personalizations] = self[:personalizations].map { |per| per.to_h }
        self[:from] = self[:from].to_h
        self[:content] = self[:content].map { |content| content.to_h }
        self[:reply_to] = self[:reply_to].to_h unless self[:reply_to].nil?
        self[:attachments] = self[:attachments].map do |att|
          att.to_h
        end unless self[:attachments].nil?
        self[:send_at] = self[:send_at].to_i if self[:send_at].class == Time
        unless self[:mail_settings].nil?
          self[:mail_settings] = self[:mail_settings].to_h
        end
        unless self[:tracking_settings].nil?
          self[:tracking_settings] = self[:tracking_settings].to_h
        end

        super.reject { |key, value| value.nil? }
      end
    end

    Content = Struct.new(:type, :value)

    Attachment = Struct.new(
      :content, :filename, :type, :disposition, :content_id
    ) do
      def set_type(type)
        self[:type] = type
        self
      end

      def set_disposition(disposition)
        self[:disposition] = disposition
        self
      end

      def set_content_id(content_id)
        self[:content_id] = content_id
        self
      end

      def to_h
        super.reject { |key, value| value.nil? }
      end
    end

    MailSettings = Struct.new(
      :bcc, :bypass_list_management, :footer, :sandbox_mode, :spam_check
    ) do
      def set_bcc(enable, email)
        self[:bcc] = {
          enable: enable,
          email: email
        }
        self
      end

      def set_bypass_list_management(enable)
        self[:bypass_list_management] = {enable: enable}
        self
      end

      def set_footer(enable, text, html)
        self[:footer] = {
          enable: enable,
          text: text,
          html: html
        }
        self
      end

      def set_sandbox_mode(enable)
        self[:sandbox_mode] = {enable: enable}
        self
      end

      def set_spam_check(enable, threshold, post_to_url)
        self[:spam_check] = {
          enable: enable,
          threshold: threshold,
          post_to_url: post_to_url
        }
        self
      end

      def to_h
        super.reject { |key, value| value.nil? }
      end
    end

    TrackingSettings = Struct.new(
      :click_tracking, :open_tracking, :subscription_tracking, :ganalytics
    ) do
      def set_click_tracking(enable, enable_text)
        self[:click_tracking] = {
          enable: enable,
          enable_text: enable_text
        }
        self
      end

      def set_open_tracking(enable, substitution_tag)
        self[:open_tracking] = {
          enable: enable,
          substitution_tag: substitution_tag
        }
        self
      end

      def set_subscription_tracking(enable, text, html, substitution_tag)
        self[:subscription_tracking] = {
          enable: enable,
          text: text,
          html: html,
          substitution_tag: substitution_tag
        }
        self
      end

      def set_ganalytics(
        enable, utm_source, utm_medium, utm_term, utm_content, utm_campaign
        )
        self[:ganalytics] = {
          enable: enable,
          utm_source: utm_source,
          utm_medium: utm_medium,
          utm_term: utm_term,
          utm_content: utm_content,
          utm_campaign: utm_campaign
        }
        self
      end

      def to_h
        super.reject { |key, value| value.nil? }
      end
    end
  end
end
