# -*- encoding: utf-8 -*-

require 'sendgrid4r/version'

require 'sendgrid4r/rest/request'
require 'sendgrid4r/rest/subusers'
require 'sendgrid4r/rest/users'

require 'sendgrid4r/rest/transactional_templates/templates'
require 'sendgrid4r/rest/transactional_templates/versions'

require 'sendgrid4r/rest/api_keys_management/api_keys'
require 'sendgrid4r/rest/api_keys_management/permissions'

require 'sendgrid4r/rest/sm/sm'
require 'sendgrid4r/rest/sm/global_unsubscribes'
require 'sendgrid4r/rest/sm/groups'
require 'sendgrid4r/rest/sm/suppressions'

require 'sendgrid4r/rest/bounces'
require 'sendgrid4r/rest/blocks'
require 'sendgrid4r/rest/invalid_emails'
require 'sendgrid4r/rest/spam_reports'
require 'sendgrid4r/rest/cancel_scheduled_sends'

require 'sendgrid4r/rest/marketing_campaigns/marketing_campaigns'
require 'sendgrid4r/rest/marketing_campaigns/contacts/custom_fields'
require 'sendgrid4r/rest/marketing_campaigns/contacts/lists'
require 'sendgrid4r/rest/marketing_campaigns/contacts/recipients'
require 'sendgrid4r/rest/marketing_campaigns/contacts/reserved_fields'
require 'sendgrid4r/rest/marketing_campaigns/contacts/segments'

require 'sendgrid4r/rest/categories'

require 'sendgrid4r/rest/email_activity'

require 'sendgrid4r/rest/ip_access_management'

require 'sendgrid4r/rest/ips/addresses'
require 'sendgrid4r/rest/ips/pools'
require 'sendgrid4r/rest/ips/warmup'

require 'sendgrid4r/rest/settings/enforced_tls'
require 'sendgrid4r/rest/settings/mail'
require 'sendgrid4r/rest/settings/partner'
require 'sendgrid4r/rest/settings/settings'
require 'sendgrid4r/rest/settings/tracking'

require 'sendgrid4r/rest/stats/advanced'
require 'sendgrid4r/rest/stats/category'
require 'sendgrid4r/rest/stats/global'
require 'sendgrid4r/rest/stats/parse'
require 'sendgrid4r/rest/stats/stats'
require 'sendgrid4r/rest/stats/subuser'

require 'sendgrid4r/rest/webhooks/event'
require 'sendgrid4r/rest/webhooks/parse'

require 'sendgrid4r/rest/whitelabel/domains'
require 'sendgrid4r/rest/whitelabel/ips'
require 'sendgrid4r/rest/whitelabel/links'

require 'sendgrid4r/factory/campaign_factory'
require 'sendgrid4r/factory/condition_factory'
require 'sendgrid4r/factory/segment_factory'
require 'sendgrid4r/factory/version_factory'

require 'sendgrid4r/rest/api'

require 'sendgrid4r/auth'
require 'sendgrid4r/client'
