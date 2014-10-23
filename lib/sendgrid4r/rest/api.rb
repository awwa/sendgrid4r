require "sendgrid4r/rest/templates"
require "sendgrid4r/rest/versions"
require "sendgrid4r/rest/groups"
require "sendgrid4r/rest/suppressions"
require "sendgrid4r/rest/global_suppressions"
require "sendgrid4r/rest/enforced_tls"
require "sendgrid4r/rest/addresses"
require "sendgrid4r/rest/pools"
require "sendgrid4r/rest/warmup"

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
    end
  end
end
