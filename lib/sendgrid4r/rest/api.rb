# -*- encoding: utf-8 -*-

module SendGrid4r::REST
  #
  # SendGrid Web API v3
  #
  module API
    include SendGrid4r::REST::TransactionalTemplates
    include SendGrid4r::REST::TransactionalTemplates::Versions
    include SendGrid4r::REST::Sm
    include SendGrid4r::REST::Sm::Groups
    include SendGrid4r::REST::Sm::Suppressions
    include SendGrid4r::REST::Sm::GlobalUnsubscribes
    include SendGrid4r::REST::Settings
    include SendGrid4r::REST::Settings::EnforcedTls
    include SendGrid4r::REST::Settings::Mail
    include SendGrid4r::REST::Settings::Partner
    include SendGrid4r::REST::Settings::Tracking
    include SendGrid4r::REST::Ips::Addresses
    include SendGrid4r::REST::Ips::Warmup
    include SendGrid4r::REST::Ips::Pools
    include SendGrid4r::REST::Categories
    include SendGrid4r::REST::Stats::Global
    include SendGrid4r::REST::Stats::Category
    include SendGrid4r::REST::Stats::Subuser
    include SendGrid4r::REST::Stats::Advanced
    include SendGrid4r::REST::Stats::Parse
    include SendGrid4r::REST::MarketingCampaigns
    include SendGrid4r::REST::MarketingCampaigns::Contacts::CustomFields
    include SendGrid4r::REST::MarketingCampaigns::Contacts::Lists
    include SendGrid4r::REST::MarketingCampaigns::Contacts::Recipients
    include SendGrid4r::REST::MarketingCampaigns::Contacts::ReservedFields
    include SendGrid4r::REST::MarketingCampaigns::Contacts::Segments
    include SendGrid4r::REST::ApiKeysManagement
    include SendGrid4r::REST::ApiKeysManagement::Permissions
    include SendGrid4r::REST::Subusers
    include SendGrid4r::REST::EmailActivity
    include SendGrid4r::REST::Whitelabel::Domains
    include SendGrid4r::REST::Whitelabel::Ips
    include SendGrid4r::REST::Whitelabel::Links
    include SendGrid4r::REST::Users
    include SendGrid4r::REST::Bounces
    include SendGrid4r::REST::Blocks
    include SendGrid4r::REST::InvalidEmails
    include SendGrid4r::REST::SpamReports
    include SendGrid4r::REST::CancelScheduledSends
    include SendGrid4r::REST::Webhooks::Event
    include SendGrid4r::REST::Webhooks::Parse
    include SendGrid4r::REST::IpAccessManagement
    include SendGrid4r::REST::Mail
  end
end
