# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe SendGrid4r::Client do
  before :all do
    Dotenv.load
  end

  describe 'unit test', :ut do
    before do
      @client = SendGrid4r::Client.new(
        username: 'username',
        password: 'password')
    end

    describe '#initialize' do
      it 'create instance with username and password' do
        @client = SendGrid4r::Client.new(
          username: 'username',
          password: 'password')
        expect(@client.class).to eq(SendGrid4r::Client)
      end

      it 'create instance with apikey' do
        @client = SendGrid4r::Client.new(api_key: 'api_key')
        expect(@client.class).to eq(SendGrid4r::Client)
      end
    end

    describe 'methods' do
      it 'available' do
        # Subusers
        expect(@client.respond_to?('get_subusers')).to eq(true)
        expect(@client.respond_to?('post_subuser')).to eq(true)
        expect(@client.respond_to?('patch_subuser')).to eq(true)
        expect(@client.respond_to?('delete_subuser')).to eq(true)
        expect(@client.respond_to?('get_subuser_monitor')).to eq(true)
        expect(@client.respond_to?('post_subuser_monitor')).to eq(true)
        expect(@client.respond_to?('put_subuser_monitor')).to eq(true)
        expect(@client.respond_to?('delete_subuser_monitor')).to eq(true)
        expect(@client.respond_to?('get_subuser_reputation')).to eq(true)
        expect(@client.respond_to?('put_subuser_assigned_ips')).to eq(true)
        # Api Keys
        expect(@client.respond_to?('get_api_keys')).to eq(true)
        expect(@client.respond_to?('post_api_key')).to eq(true)
        expect(@client.respond_to?('delete_api_key')).to eq(true)
        expect(@client.respond_to?('patch_api_key')).to eq(true)
        # Advanced Suppression Manager
        # groups
        expect(@client.respond_to?('get_groups')).to eq(true)
        expect(@client.respond_to?('get_group')).to eq(true)
        expect(@client.respond_to?('post_group')).to eq(true)
        expect(@client.respond_to?('patch_group')).to eq(true)
        expect(@client.respond_to?('delete_group')).to eq(true)
        # suppressions
        expect(@client.respond_to?('post_suppressed_emails')).to eq(true)
        expect(@client.respond_to?('get_suppressions')).to eq(true)
        expect(@client.respond_to?('get_suppressed_emails')).to eq(true)
        expect(@client.respond_to?('delete_suppressed_email')).to eq(true)
        # global suppressions
        expect(@client.respond_to?('get_global_unsubscribes')).to eq(true)
        expect(@client.respond_to?('post_global_suppressed_emails')).to eq(true)
        expect(@client.respond_to?('get_global_suppressed_email')).to eq(true)
        expect(
          @client.respond_to?('delete_global_suppressed_email')
        ).to eq(true)
        # IP Management
        # ip addresses
        expect(@client.respond_to?('get_ips')).to eq(true)
        expect(@client.respond_to?('get_ips_assigned')).to eq(true)
        expect(@client.respond_to?('get_ip')).to eq(true)
        expect(@client.respond_to?('post_ip_to_pool')).to eq(true)
        expect(@client.respond_to?('delete_ip_from_pool')).to eq(true)
        # pool
        expect(@client.respond_to?('get_pools')).to eq(true)
        expect(@client.respond_to?('post_pool')).to eq(true)
        expect(@client.respond_to?('get_pool')).to eq(true)
        expect(@client.respond_to?('put_pool')).to eq(true)
        expect(@client.respond_to?('delete_pool')).to eq(true)
        # warmup
        expect(@client.respond_to?('get_warmup_ips')).to eq(true)
        expect(@client.respond_to?('get_warmup_ip')).to eq(true)
        expect(@client.respond_to?('post_warmup_ip')).to eq(true)
        expect(@client.respond_to?('delete_warmup_ip')).to eq(true)
        # Settings
        # enforced_tls
        expect(@client.respond_to?('get_enforced_tls')).to eq(true)
        expect(@client.respond_to?('patch_enforced_tls')).to eq(true)
        # mail
        expect(@client.respond_to?('get_mail_settings')).to eq(true)
        expect(
          @client.respond_to?('get_settings_address_whitelist')
        ).to eq(true)
        expect(
          @client.respond_to?('patch_settings_address_whitelist')
        ).to eq(true)
        expect(@client.respond_to?('get_settings_bcc')).to eq(true)
        expect(@client.respond_to?('patch_settings_bcc')).to eq(true)
        expect(@client.respond_to?('get_settings_bounce_purge')).to eq(true)
        expect(@client.respond_to?('patch_settings_bounce_purge')).to eq(true)
        expect(
          @client.respond_to?('get_settings_event_notification')
        ).to eq(true)
        expect(
          @client.respond_to?('patch_settings_event_notification')
        ).to eq(true)
        expect(
          @client.respond_to?('test_settings_event_notification')
        ).to eq(true)
        expect(@client.respond_to?('get_settings_footer')).to eq(true)
        expect(@client.respond_to?('patch_settings_footer')).to eq(true)
        expect(@client.respond_to?('get_settings_forward_bounce')).to eq(true)
        expect(@client.respond_to?('patch_settings_forward_bounce')).to eq(true)
        expect(@client.respond_to?('get_settings_forward_spam')).to eq(true)
        expect(@client.respond_to?('patch_settings_forward_spam')).to eq(true)
        expect(@client.respond_to?('get_settings_template')).to eq(true)
        expect(@client.respond_to?('patch_settings_template')).to eq(true)
        expect(@client.respond_to?('get_settings_plain_content')).to eq(true)
        expect(@client.respond_to?('patch_settings_plain_content')).to eq(true)

        # partner
        expect(@client.respond_to?('get_partner_settings')).to eq(true)
        expect(@client.respond_to?('get_settings_new_relic')).to eq(true)
        expect(@client.respond_to?('patch_settings_new_relic')).to eq(true)

        # tracking
        expect(@client.respond_to?('get_tracking_settings')).to eq(true)
        expect(@client.respond_to?('get_settings_click')).to eq(true)
        expect(@client.respond_to?('patch_settings_click')).to eq(true)
        expect(@client.respond_to?('get_settings_google_analytics')).to eq(true)
        expect(
          @client.respond_to?('patch_settings_google_analytics')
        ).to eq(true)
        expect(@client.respond_to?('get_settings_open')).to eq(true)
        expect(@client.respond_to?('patch_settings_open')).to eq(true)
        expect(@client.respond_to?('get_settings_subscription')).to eq(true)
        expect(@client.respond_to?('patch_settings_subscription')).to eq(true)

        # Template Engine
        # templates
        expect(@client.respond_to?('get_templates')).to eq(true)
        expect(@client.respond_to?('get_template')).to eq(true)
        expect(@client.respond_to?('post_template')).to eq(true)
        expect(@client.respond_to?('patch_template')).to eq(true)
        expect(@client.respond_to?('delete_template')).to eq(true)
        # versions
        expect(@client.respond_to?('get_version')).to eq(true)
        expect(@client.respond_to?('post_version')).to eq(true)
        expect(@client.respond_to?('activate_version')).to eq(true)
        expect(@client.respond_to?('patch_version')).to eq(true)
        expect(@client.respond_to?('delete_version')).to eq(true)
        # Categories
        expect(@client.respond_to?('get_categories')).to eq(true)
        # Stats
        expect(@client.respond_to?('get_global_stats')).to eq(true)
        expect(@client.respond_to?('get_categories_stats')).to eq(true)
        expect(@client.respond_to?('get_categories_stats_sums')).to eq(true)
        expect(@client.respond_to?('get_subusers_stats')).to eq(true)
        expect(@client.respond_to?('get_subusers_stats_sums')).to eq(true)
        expect(@client.respond_to?('get_geo_stats')).to eq(true)
        expect(@client.respond_to?('get_devices_stats')).to eq(true)
        expect(@client.respond_to?('get_clients_stats')).to eq(true)
        expect(@client.respond_to?('get_clients_type_stats')).to eq(true)
        expect(@client.respond_to?('get_mailbox_providers_stats')).to eq(true)
        expect(@client.respond_to?('get_browsers_stats')).to eq(true)
        expect(@client.respond_to?('get_parse_stats')).to eq(true)
        # Contacts
        # CustomFields
        expect(@client.respond_to?('post_custom_field')).to eq(true)
        expect(@client.respond_to?('get_custom_fields')).to eq(true)
        expect(@client.respond_to?('get_custom_field')).to eq(true)
        expect(@client.respond_to?('delete_custom_field')).to eq(true)
        # Lists
        expect(@client.respond_to?('post_list')).to eq(true)
        expect(@client.respond_to?('get_lists')).to eq(true)
        expect(@client.respond_to?('get_list')).to eq(true)
        expect(@client.respond_to?('patch_list')).to eq(true)
        expect(@client.respond_to?('delete_list')).to eq(true)
        expect(@client.respond_to?('post_recipients_to_list')).to eq(true)
        expect(@client.respond_to?('get_recipients_from_list')).to eq(true)
        expect(@client.respond_to?('post_recipients_to_list')).to eq(true)
        expect(@client.respond_to?('delete_recipient_from_list')).to eq(true)
        expect(@client.respond_to?('delete_lists')).to eq(true)
        # Recipients
        expect(@client.respond_to?('post_recipients')).to eq(true)
        expect(@client.respond_to?('patch_recipients')).to eq(true)
        expect(@client.respond_to?('delete_recipients')).to eq(true)
        expect(@client.respond_to?('get_recipients')).to eq(true)
        expect(@client.respond_to?('get_recipient')).to eq(true)
        expect(@client.respond_to?('delete_recipient')).to eq(true)
        expect(@client.respond_to?('get_lists_recipient_belong')).to eq(true)
        expect(@client.respond_to?('get_recipients_count')).to eq(true)
        expect(@client.respond_to?('search_recipients')).to eq(true)
        # ReservedFields
        expect(@client.respond_to?('get_reserved_fields')).to eq(true)
        # Segments
        expect(@client.respond_to?('post_segment')).to eq(true)
        expect(@client.respond_to?('get_segments')).to eq(true)
        expect(@client.respond_to?('get_segment')).to eq(true)
        expect(@client.respond_to?('patch_segment')).to eq(true)
        expect(@client.respond_to?('delete_segment')).to eq(true)
        expect(@client.respond_to?('get_recipients_on_segment')).to eq(true)

        # Campaigns
        expect(@client.respond_to?('post_campaign')).to eq(true)
        expect(@client.respond_to?('get_campaigns')).to eq(true)
        expect(@client.respond_to?('get_campaign')).to eq(true)
        expect(@client.respond_to?('delete_campaign')).to eq(true)
        expect(@client.respond_to?('patch_campaign')).to eq(true)
        expect(@client.respond_to?('send_campaign')).to eq(true)
        expect(@client.respond_to?('schedule_campaign')).to eq(true)
        expect(@client.respond_to?('schedule_campaign')).to eq(true)
        expect(@client.respond_to?('reschedule_campaign')).to eq(true)
        expect(@client.respond_to?('get_schedule_time_campaign')).to eq(true)
        expect(@client.respond_to?('unschedule_campaign')).to eq(true)
        expect(@client.respond_to?('test_campaign')).to eq(true)

        # Whitelabel
        # Domains
        expect(@client.respond_to?('get_wl_domains')).to eq(true)
        expect(@client.respond_to?('post_wl_domain')).to eq(true)
        expect(@client.respond_to?('get_wl_domain')).to eq(true)
        expect(@client.respond_to?('patch_wl_domain')).to eq(true)
        expect(@client.respond_to?('delete_wl_domain')).to eq(true)
        expect(@client.respond_to?('get_default_wl_domain')).to eq(true)
        expect(@client.respond_to?('add_ip_to_wl_domain')).to eq(true)
        expect(@client.respond_to?('remove_ip_from_wl_domain')).to eq(true)
        expect(@client.respond_to?('validate_wl_domain')).to eq(true)
        expect(@client.respond_to?('get_associated_wl_domain')).to eq(true)
        expect(@client.respond_to?('disassociate_wl_domain')).to eq(true)
        expect(@client.respond_to?('associate_wl_domain')).to eq(true)

        # IPs
        expect(@client.respond_to?('get_wl_ips')).to eq(true)
        expect(@client.respond_to?('post_wl_ip')).to eq(true)
        expect(@client.respond_to?('get_wl_ip')).to eq(true)
        expect(@client.respond_to?('delete_wl_ip')).to eq(true)
        expect(@client.respond_to?('validate_wl_ip')).to eq(true)

        # Email Links
        expect(@client.respond_to?('get_wl_links')).to eq(true)
        expect(@client.respond_to?('post_wl_link')).to eq(true)
        expect(@client.respond_to?('get_wl_link')).to eq(true)
        expect(@client.respond_to?('patch_wl_link')).to eq(true)
        expect(@client.respond_to?('delete_wl_link')).to eq(true)
        expect(@client.respond_to?('get_default_wl_link')).to eq(true)
        expect(@client.respond_to?('validate_wl_link')).to eq(true)
        expect(@client.respond_to?('get_associated_wl_link')).to eq(true)
        expect(@client.respond_to?('disassociate_wl_link')).to eq(true)
        expect(@client.respond_to?('associate_wl_link')).to eq(true)

        # Users API
        expect(@client.respond_to?('get_user_profile')).to eq(true)
        expect(@client.respond_to?('patch_user_profile')).to eq(true)
        expect(@client.respond_to?('get_user_account')).to eq(true)

        # Bounces API
        expect(@client.respond_to?('get_bounces')).to eq(true)
        expect(@client.respond_to?('delete_bounces')).to eq(true)
        expect(@client.respond_to?('get_bounce')).to eq(true)
        expect(@client.respond_to?('delete_bounce')).to eq(true)

        # Blocks API
        expect(@client.respond_to?('get_blocks')).to eq(true)
        expect(@client.respond_to?('delete_blocks')).to eq(true)
        expect(@client.respond_to?('get_block')).to eq(true)
        expect(@client.respond_to?('delete_block')).to eq(true)

        # Invalid Emails API
        expect(@client.respond_to?('get_invalid_emails')).to eq(true)
        expect(@client.respond_to?('delete_invalid_emails')).to eq(true)
        expect(@client.respond_to?('get_invalid_email')).to eq(true)
        expect(@client.respond_to?('delete_invalid_email')).to eq(true)

        # Spam Reports API
        expect(@client.respond_to?('get_spam_reports')).to eq(true)
        expect(@client.respond_to?('delete_spam_reports')).to eq(true)
        expect(@client.respond_to?('get_spam_report')).to eq(true)
        expect(@client.respond_to?('delete_spam_report')).to eq(true)

        # Cancel Scheduled Sends Api
        expect(@client.respond_to?('generate_batch_id')).to eq(true)
        expect(@client.respond_to?('validate_batch_id')).to eq(true)
        expect(@client.respond_to?('post_scheduled_send')).to eq(true)
        expect(@client.respond_to?('get_scheduled_sends')).to eq(true)
        expect(@client.respond_to?('patch_scheduled_send')).to eq(true)
        expect(@client.respond_to?('delete_scheduled_send')).to eq(true)

        # Api Keys
        expect(@client.respond_to?('get_api_keys')).to eq(true)
        expect(@client.respond_to?('post_api_key')).to eq(true)
        expect(@client.respond_to?('get_api_key')).to eq(true)
        expect(@client.respond_to?('delete_api_key')).to eq(true)
        expect(@client.respond_to?('patch_api_key')).to eq(true)
        expect(@client.respond_to?('put_api_key')).to eq(true)

        # Permissions
        expect(@client.respond_to?('get_permissions')).to eq(true)

        # Ip Access Management
        expect(@client.respond_to?('get_ip_activities')).to eq(true)
        expect(@client.respond_to?('get_whitelisted_ips')).to eq(true)
        expect(@client.respond_to?('post_whitelisted_ips')).to eq(true)
        expect(@client.respond_to?('delete_whitelisted_ips')).to eq(true)
        expect(@client.respond_to?('get_whitelisted_ip')).to eq(true)
        expect(@client.respond_to?('delete_whitelisted_ip')).to eq(true)
      end
    end

    describe 'VERSION' do
      it 'returns VERSION value' do
        expect(SendGrid4r::VERSION).to eq('1.7.0')
      end
    end
  end
end
