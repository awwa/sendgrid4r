# -*- encoding: utf-8 -*-

require 'sendgrid4r/version'

require 'sendgrid4r/rest/request'
require 'sendgrid4r/rest/subusers'
require 'sendgrid4r/rest/users'

require 'sendgrid4r/rest/templates/templates'
require 'sendgrid4r/rest/templates/versions'

require 'sendgrid4r/rest/api_keys/api_keys'
require 'sendgrid4r/rest/api_keys/permissions'

require 'sendgrid4r/rest/asm/asm'
require 'sendgrid4r/rest/asm/global_suppressions'
require 'sendgrid4r/rest/asm/groups'
require 'sendgrid4r/rest/asm/suppressions'

require 'sendgrid4r/rest/bounces'
require 'sendgrid4r/rest/cancel_scheduled_sends'

require 'sendgrid4r/rest/campaigns/campaigns'

require 'sendgrid4r/rest/categories/categories'

require 'sendgrid4r/rest/contacts/custom_fields'
require 'sendgrid4r/rest/contacts/lists'
require 'sendgrid4r/rest/contacts/recipients'
require 'sendgrid4r/rest/contacts/reserved_fields'
require 'sendgrid4r/rest/contacts/segments'

require 'sendgrid4r/rest/email_activity/email_activity'

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

require 'sendgrid4r/rest/webhooks/parse_api'

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
