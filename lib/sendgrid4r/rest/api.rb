# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sendgrid4r/rest/templates/templates'
require 'sendgrid4r/rest/templates/versions'
require 'sendgrid4r/rest/asm/asm'
require 'sendgrid4r/rest/asm/groups'
require 'sendgrid4r/rest/asm/suppressions'
require 'sendgrid4r/rest/asm/global_suppressions'
require 'sendgrid4r/rest/settings/settings'
require 'sendgrid4r/rest/settings/enforced_tls'
require 'sendgrid4r/rest/settings/mail'
require 'sendgrid4r/rest/settings/partner'
require 'sendgrid4r/rest/settings/tracking'
require 'sendgrid4r/rest/ips/addresses'
require 'sendgrid4r/rest/ips/pools'
require 'sendgrid4r/rest/ips/warmup'
require 'sendgrid4r/rest/categories/categories'
require 'sendgrid4r/rest/stats/stats'
require 'sendgrid4r/rest/stats/global'
require 'sendgrid4r/rest/stats/category'
require 'sendgrid4r/rest/stats/subuser'
require 'sendgrid4r/rest/stats/advanced'
require 'sendgrid4r/rest/stats/parse'
require 'sendgrid4r/rest/contacts/custom_fields'
require 'sendgrid4r/rest/contacts/lists'
require 'sendgrid4r/rest/contacts/recipients'
require 'sendgrid4r/rest/contacts/reserved_fields'
require 'sendgrid4r/rest/contacts/segments'
require 'sendgrid4r/rest/campaigns/campaigns'
require 'sendgrid4r/rest/api_keys/api_keys'
require 'sendgrid4r/rest/api_keys/permissions'
require 'sendgrid4r/rest/subusers'
require 'sendgrid4r/rest/email_activity/email_activity'
require 'sendgrid4r/rest/whitelabel/domains'
require 'sendgrid4r/rest/whitelabel/ips'
require 'sendgrid4r/rest/whitelabel/links'
require 'sendgrid4r/rest/users'
require 'sendgrid4r/rest/bounces'
require 'sendgrid4r/rest/cancel_scheduled_sends'
require 'sendgrid4r/rest/webhooks/parse_api'

module SendGrid4r
  module REST
    #
    # SendGrid Web API v3
    #
    module API
      include SendGrid4r::REST::Templates
      include SendGrid4r::REST::Templates::Versions
      include SendGrid4r::REST::Asm
      include SendGrid4r::REST::Asm::Groups
      include SendGrid4r::REST::Asm::Suppressions
      include SendGrid4r::REST::Asm::GlobalSuppressions
      include SendGrid4r::REST::Settings
      include SendGrid4r::REST::Settings::EnforcedTls
      include SendGrid4r::REST::Settings::Mail
      include SendGrid4r::REST::Settings::Partner
      include SendGrid4r::REST::Settings::Tracking
      include SendGrid4r::REST::Ips::Addresses
      include SendGrid4r::REST::Ips::Warmup
      include SendGrid4r::REST::Ips::Pools
      include SendGrid4r::REST::Categories::Categories
      include SendGrid4r::REST::Stats::Global
      include SendGrid4r::REST::Stats::Category
      include SendGrid4r::REST::Stats::Subuser
      include SendGrid4r::REST::Stats::Advanced
      include SendGrid4r::REST::Stats::Parse
      include SendGrid4r::REST::Contacts::CustomFields
      include SendGrid4r::REST::Contacts::Lists
      include SendGrid4r::REST::Contacts::Recipients
      include SendGrid4r::REST::Contacts::ReservedFields
      include SendGrid4r::REST::Contacts::Segments
      include SendGrid4r::REST::Campaigns::Campaigns
      include SendGrid4r::REST::ApiKeys
      include SendGrid4r::REST::ApiKeys::Permissions
      include SendGrid4r::REST::Subusers
      include SendGrid4r::REST::EmailActivity
      include SendGrid4r::REST::Whitelabel::Domains
      include SendGrid4r::REST::Whitelabel::Ips
      include SendGrid4r::REST::Whitelabel::Links
      include SendGrid4r::REST::Users
      include SendGrid4r::REST::Bounces
      include SendGrid4r::REST::CancelScheduledSends
      include SendGrid4r::REST::Webhooks::ParseApi
    end
  end
end
