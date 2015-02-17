require "sendgrid4r/rest/templates"
require "sendgrid4r/rest/versions"
require "sendgrid4r/rest/groups"
require "sendgrid4r/rest/suppressions"
require "sendgrid4r/rest/global_suppressions"
require "sendgrid4r/rest/enforced_tls"
require "sendgrid4r/rest/addresses"
require "sendgrid4r/rest/pools"
require "sendgrid4r/rest/warmup"
require "sendgrid4r/rest/categories"
require "sendgrid4r/rest/stats/stats"
require "sendgrid4r/rest/stats/global"
require "sendgrid4r/rest/stats/category"
require "sendgrid4r/rest/stats/subuser"
require "sendgrid4r/rest/stats/advanced"
require "sendgrid4r/rest/stats/parse"

module SendGrid4r
  module REST
    module API
      include SendGrid4r::REST::Templates
      include SendGrid4r::REST::Templates::Versions
      include SendGrid4r::REST::Asm::Groups
      include SendGrid4r::REST::Asm::Suppressions
      include SendGrid4r::REST::Asm::GlobalSuppressions
      include SendGrid4r::REST::Settings::EnforcedTls
      include SendGrid4r::REST::Ips::Addresses
      include SendGrid4r::REST::Ips::Warmup
      include SendGrid4r::REST::Ips::Pools
      include SendGrid4r::REST::Categories::Categories
      include SendGrid4r::REST::Stats::Global
      include SendGrid4r::REST::Stats::Category
      include SendGrid4r::REST::Stats::Subuser
      include SendGrid4r::REST::Stats::Advanced
      include SendGrid4r::REST::Stats::Parse
    end
  end
end
