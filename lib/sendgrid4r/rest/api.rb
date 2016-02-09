# -*- encoding: utf-8 -*-

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
