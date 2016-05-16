# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3 Mail
  #
  module Mail
    Email = Struct.new(:email, :name) do
      def to_h
        super.reject { |_key, value| value.nil? }
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
        self[:to] = self[:to].map(&:to_h)
        self[:cc] = self[:cc].map(&:to_h) unless self[:cc].nil?
        self[:bcc] = self[:bcc].map(&:to_h) unless self[:bcc].nil?
        self[:send_at] = self[:send_at].to_i if self[:send_at].class == Time
        super.reject { |_key, value| value.nil? }
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
        self[:asm] = { group_id: group_id }
        unless groups_to_display.nil?
          self[:asm][:groups_to_display] = groups_to_display
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
        self[:personalizations] = self[:personalizations].map(&:to_h)
        self[:from] = self[:from].to_h
        self[:content] = self[:content].map(&:to_h)
        self[:reply_to] = self[:reply_to].to_h unless self[:reply_to].nil?
        unless self[:attachments].nil?
          self[:attachments] = self[:attachments].map(&:to_h)
        end
        self[:send_at] = self[:send_at].to_i if self[:send_at].class == Time
        unless self[:mail_settings].nil?
          self[:mail_settings] = self[:mail_settings].to_h
        end
        unless self[:tracking_settings].nil?
          self[:tracking_settings] = self[:tracking_settings].to_h
        end
        super.reject { |_key, value| value.nil? }
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
        super.reject { |_key, value| value.nil? }
      end
    end

    MailSettings = Struct.new(
      :bcc, :bypass_list_management, :footer, :sandbox_mode, :spam_check
    ) do
      def set_bcc(enable, email = nil)
        self[:bcc] = { enable: enable }
        self[:bcc][:email] = email unless email.nil?
        self
      end

      def set_bypass_list_management(enable)
        self[:bypass_list_management] = { enable: enable }
        self
      end

      def set_footer(enable, text = nil, html = nil)
        self[:footer] = { enable: enable }
        self[:footer][:text] = text unless text.nil?
        self[:footer][:html] = html unless html.nil?
        self
      end

      def set_sandbox_mode(enable)
        self[:sandbox_mode] = { enable: enable }
        self
      end

      def set_spam_check(enable, threshold = nil, post_to_url = nil)
        self[:spam_check] = { enable: enable }
        self[:spam_check][:threshold] = threshold unless threshold.nil?
        self[:spam_check][:post_to_url] = post_to_url unless post_to_url.nil?
        self
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end

    TrackingSettings = Struct.new(
      :click_tracking, :open_tracking, :subscription_tracking, :ganalytics
    ) do
      def set_click_tracking(enable, enable_text = nil)
        self[:click_tracking] = { enable: enable }
        unless enable_text.nil?
          self[:click_tracking][:enable_text] = enable_text
        end
        self
      end

      def set_open_tracking(enable, substitution_tag = nil)
        self[:open_tracking] = { enable: enable }
        unless substitution_tag.nil?
          self[:open_tracking][:substitution_tag] = substitution_tag
        end
        self
      end

      def set_subscription_tracking(
        enable, text = nil, html = nil, substitution_tag = nil
      )
        self[:subscription_tracking] = { enable: enable }
        self[:subscription_tracking][:text] = text unless text.nil?
        self[:subscription_tracking][:html] = html unless html.nil?
        unless substitution_tag.nil?
          self[:subscription_tracking][:substitution_tag] = substitution_tag
        end
        self
      end

      def set_ganalytics(
        enable, utm_source = nil, utm_medium = nil, utm_term = nil,
        utm_content = nil, utm_campaign = nil
      )
        self[:ganalytics] = { enable: enable }
        self[:ganalytics][:utm_source] = utm_source unless utm_source.nil?
        self[:ganalytics][:utm_medium] = utm_medium unless utm_medium.nil?
        self[:ganalytics][:utm_term] = utm_term unless utm_term.nil?
        self[:ganalytics][:utm_content] = utm_content unless utm_content.nil?
        self[:ganalytics][:utm_campaign] = utm_campaign unless utm_campaign.nil?
        self
      end

      def to_h
        super.reject { |_key, value| value.nil? }
      end
    end
  end
end
