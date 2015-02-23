# Sendgrid4r

This gem allows you to quickly and easily access to SendGrid Web API v3 for Ruby.
See [api reference](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html) for more detail

[![Build Status](https://travis-ci.org/awwa/sendgrid4r.svg?branch=master)](https://travis-ci.org/awwa/sendgrid4r)

- [Installation](#installation)
- [Usage](#usage)
  - [Create a client instance](#create-a-client-instance)
  - [Advanced Suppression Manager](#Advanced Suppression Manager)
    - [Groups](#groups)
    - [Suppressions](#suppressions)
    - [Global Suppressions](#global-suppressions)
  - [Categories](#categories)
    - [Categories](#categories)
  - [IP Management](#ip-management)
    - [IP Addresses](#ip-addresses)
    - [IP Pools](#ip-pools)
    - [IP Warmup](#ip-warmup)
  - [Settings](#settings)
    - [Enforced TLS](#enforced-tls)
  - [Stats](#stats)
    - [Global Stats](#global-stats)
    - [Category Stats](#category-stats)
    - [Subuser Stats](#subuser-stats)
    - [Advanced Stats](#advanced-stats)
  - [Template Engine](#template-engine)
    - [Templates](#templates)
    - [Versions](#versions)
- [Contributing](#contributing)

## Installation

Add this line to your application's Gemfile:

    gem 'sendgrid4r'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sendgrid4r

## Usage

### Create a client instance

Create a SendGrid::Client instance for API call.

```Ruby
require "sendgrid4r"
client = Sendgrid4r::Client.new("user", "pass")
```

----
### Advanced Suppression Manager
#### [Groups](https://sendgrid.com/docs/API_Reference/Web_API_v3/Advanced_Suppression_Manager/groups.html)
##### POST
Create a new suppression group.
```Ruby
new_group = client.post_group("group_name", "group_desc")
```

##### GET
Retrieve all suppression groups associated with your account.
```Ruby
groups = client.get_groups
groups.each{|group|
  puts group.id                 # => 100
  puts group.name               # => "Newsletters"
  puts group.description        # => "Our monthly newsletter."
  puts group.last_email_sent_at # => "2014-09-04 01:34:43"
  puts group.unsubscribes       # => 400
}
```

##### GET
Get information on a single suppression group.
```Ruby
group = client.get_group(100)
puts group.id                 # => 100
puts group.name               # => "Newsletters"
puts group.description        # => "Our monthly newsletter."
puts group.last_email_sent_at # => "2014-09-04 01:34:43"
puts group.unsubscribes       # => 400
```

##### PATCH
Update a suppression group.
```Ruby
new_group.name = "group_edit"
new_group.description = "group_desc_edit"
client.patch_group(new_group.id, new_group)
```

##### DELETE
Delete a suppression group.
```Ruby
client.delete_group(100)
```

#### [Suppressions](https://sendgrid.com/docs/API_Reference/Web_API_v3/Advanced_Suppression_Manager/suppressions.html)
##### POST
Add recipient emails to the suppressions list for a given group.
```Ruby
emails = client.post_suppressed_emails(group.id, ["email1@address.com", "email2@address.com", "email3@address.com"])
```

##### GET
Get suppressions associated with a recipient email.
```Ruby
suppressions = client.get_suppressions("email@address.com")
suppressions.each{|suppression|
  puts suppression.id           # => 1
  puts suppression.name         # => "Weekly Newsletter"
  puts suppression.description  # => "The weekly newsletter"
  puts suppression.suppressed   # => true/false
}
```

##### GET
Retrieve suppressed emails for a group.
```Ruby
emails = client.get_suppressed_emails(100)
emails.each{|email|
  puts email
}
```

##### DELETE
Delete a recipient email from the suppressions list for a given group.
```Ruby
client.delete_suppressed_email(100, "email1@address.com")
```

#### [Global Suppressions](https://sendgrid.com/docs/API_Reference/Web_API_v3/Advanced_Suppression_Manager/global_suppressions.html)
##### POST
Add recipient emails to the global suppression group.
```Ruby
emails = client.post_global_suppressed_emails(["email1@address.com", "email2@address.com", "email3@address.com"])
```

##### GET
Check if an address is in the global suppressions group.
```Ruby
email1 = client.get_global_suppressed_email("email1@address.com")
```

##### DELETE
Delete a recipient email from the global suppressions group.
```Ruby
client.delete_global_suppressed_email("email1@address.com")
```

----
### Categories
#### [Categories](https://sendgrid.com/docs/API_Reference/Web_API_v3/Categories/categories.html)
##### GET
Retrieve a list of your categories.
```Ruby
categories = client.get_categories
categories.each do |cat|
  puts cat.category     # => "cat1"
end
```
```Ruby
categories = client.get_categories("abc", 100, 200)
categories.each do |cat|
  puts cat.category     # => "cat1"
end
```

----
### IP Management
#### [IP Addresses](https://sendgrid.com/docs/API_Reference/Web_API_v3/IP_Management/ip_addresses.html)
##### POST
Add an IP to a pool.
```Ruby
ip = client.post_ip_to_pool("pool_name", "xxx.xxx.xxx.xxx")
puts ip.ip            # => "xxx.xxx.xxx.xxx"
puts ip.pools         # => ["test1"]
puts ip.start_date    # => 140961600
puts ip.warmup        # => true/false
```

##### GET
See a list of all IPs and the IPs, including warm up status and pools.
```Ruby
ips = client.get_ips
ips.each do |ip|
  puts ip.ip            # => "xxx.xxx.xxx.xxx"
  puts ip.pools         # => ["new_test5"]
  puts ip.warmup        # => true/false
  puts ip.start_date    # => 1409616000
  puts ip.subusers      # => ["username1", "username2"]
  puts ip.rdns          # => "01.email.test.com"
end
```

##### GET
See only assigned IPs.
```Ruby
ips = client.get_ips_assigned
ips.each do |ip|
  puts ip.ip            # => "xxx.xxx.xxx.xxx"
  puts ip.pools         # => ["new_test5"]
  puts ip.warmup        # => true/false
  puts ip.start_date    # => 1409616000
end
```

##### GET
See which pools an IP address belongs to.
```Ruby
ip_belong = client.get_ip("xxx.xxx.xxx.xxx")
ip_belong.ips.each do |ip|
  puts ip.ip              # => "0.0.0.0"
  puts ip.start_date      # => 1409616000
  puts ip.warmup          # => true/false
end
puts ip_belong.pool_name  # => "test1"
```

##### DELETE
Remove an IP address from a pool.
```Ruby
client.delete_ip_from_pool("pool_name", "xxx.xxx.xxx.xxx")
```

#### [IP Pools](https://sendgrid.com/docs/API_Reference/Web_API_v3/IP_Management/ip_pools.html)
##### POST
Create an IP pool.
```Ruby
pool = client.post_pool("name")
puts pool.name        # => "marketing"
```

##### GET
List all IP pools.
```Ruby
pools = client.get_pools
pools.each do |pool|
  puts pool.name      # => "test1"
end
```

##### GET
List the IPs in a specified pool.
```Ruby
pool = client.get_pool("name")
puts pool.name        # => "name"
puts pool.ips.inspect # => ["167.89.21.3"]
```

##### PUT
Update an IP pool’s name
```Ruby
client.put_pool("name", "new_pool_name")
puts pool.name        # => "new_pool_name"
```

##### DELETE
Delete an IP pool.
```Ruby
client.delete_pool("name")
```

#### [IP Warmup](https://sendgrid.com/docs/API_Reference/Web_API_v3/IP_Management/ip_warmup.html)
##### GET
Get all IPs that are currently warming up.
```Ruby
warmup_ips = client.get_warmup_ips
warmup_ips.each do |warmup_ip|
  puts warmup_ip.ip         # => "xxx.xxx.xxx.xxx"
  puts warmup_ip.start_date # => 1409616000
end
```

##### GET
Get warmup status for a particular IP.
```Ruby
warmup_ip = client.get_warmup_ip("xxx.xxx.xxx.xxx")
puts warmup_ip.ip         # => "xxx.xxx.xxx.xxx"
puts warmup_ip.start_date # => 1409616000
```

##### POST
Add an IP to warmup.
```Ruby
warmup_ip = client.post_warmup_ip("xxx.xxx.xxx.xxx")
puts warmup_ip.ip         # => "xxx.xxx.xxx.xxx"
puts warmup_ip.start_date # => 1409616000
```

##### DELETE
Remove an IP from warmup.
```Ruby
client.delete_warmup_ip("xxx.xxx.xxx.xxx")
```

----
### Settings
#### [Enforced TLS](https://sendgrid.com/docs/API_Reference/Web_API_v3/Settings/enforced_tls.html)
##### GET
Get the current Enforced TLS settings.
```Ruby
enforced_tls = client.get_enforced_tls
puts enforced_tls.require_tls         # => true/false
puts enforced_tls.require_valid_cert  # => true/false
```

##### PATCH
Change the Enforced TLS settings.
```Ruby
enforced_tls = client.get_enforced_tls
enforced_tls.require_tls = true
enforced_tls.require_valid_cert = true
new_enforced_tls = client.patch_enforced_tls(enforced_tls)
puts new_enforced_tls.require_tls         # => true/false
puts new_enforced_tls.require_valid_cert  # => true/false
```

----
### Stats
#### [Global Stats](https://sendgrid.com/docs/API_Reference/Web_API_v3/Stats/global.html)
##### GET
Global Stats provide all of your user’s email statistics for a given date range.
```Ruby
stats = client.get_global_stats(
  start_date: "2015-01-01"
)
stats = client.get_global_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.blocks             # => 1
    puts metrics.bounce_drops       # => 1
    puts metrics.bounces            # => 1
    puts metrics.clicks             # => 1
    puts metrics.deferred           # => 1
    puts metrics.delivered          # => 1
    puts metrics.invalid_emails     # => 1
    puts metrics.opens              # => 1
    puts metrics.processed          # => 1
    puts metrics.requests           # => 1
    puts metrics.spam_report_drops  # => 1
    puts metrics.spam_reports       # => 1
    puts metrics.unique_clicks      # => 1
    puts metrics.unique_opens       # => 1
    puts metrics.unsubscribe_drops  # => 1
    puts metrics.unsubscribes       # => 1
  end
end
```

#### [Category Stats](https://sendgrid.com/docs/API_Reference/Web_API_v3/Stats/categories.html)
##### GET
Category Stats provide all of your user’s email statistics for your categories.
```Ruby
stats = client.get_category_stats(
  start_date: "2015-01-01",
  categories: "cat"
)
stats = client.get_category_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  categories: "cat"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.blocks             # => 1
    puts metrics.bounce_drops       # => 1
    puts metrics.bounces            # => 1
    puts metrics.clicks             # => 1
    puts metrics.deferred           # => 1
    puts metrics.delivered          # => 1
    puts metrics.invalid_emails     # => 1
    puts metrics.opens              # => 1
    puts metrics.processed          # => 1
    puts metrics.requests           # => 1
    puts metrics.spam_report_drops  # => 1
    puts metrics.spam_reports       # => 1
    puts metrics.unique_clicks      # => 1
    puts metrics.unique_opens       # => 1
    puts metrics.unsubscribe_drops  # => 1
    puts metrics.unsubscribes       # => 1
  end
  puts stat.name      # => "cat1"
  puts stat.type      # => "category"
end
```

#### [Subuser Stats](https://sendgrid.com/docs/API_Reference/Web_API_v3/Stats/subusers.html)
##### GET
Subuser Stats provide all of your user’s email statistics for your subuser accounts.
```Ruby
stats = client.get_subuser_stats(
  start_date: "2015-01-01",
  subusers: "subusername"
)
stats = client.get_subuser_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  subusers: "subusername"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.blocks             # => 1
    puts metrics.bounce_drops       # => 1
    puts metrics.bounces            # => 1
    puts metrics.clicks             # => 1
    puts metrics.deferred           # => 1
    puts metrics.delivered          # => 1
    puts metrics.invalid_emails     # => 1
    puts metrics.opens              # => 1
    puts metrics.processed          # => 1
    puts metrics.requests           # => 1
    puts metrics.spam_report_drops  # => 1
    puts metrics.spam_reports       # => 1
    puts metrics.unique_clicks      # => 1
    puts metrics.unique_opens       # => 1
    puts metrics.unsubscribe_drops  # => 1
    puts metrics.unsubscribes       # => 1
  end
  puts stat.name      # => "cat1"
  puts stat.type      # => "subuser"
end
```

##### GET
Gets the total sums of each email statistic metric for all subusers over the given date range.
```Ruby
stats = client.get_subuser_stats_sums(
  start_date: "2015-01-01"
)
stat = client.get_subuser_stats_sums(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  sort_by_metric: "opens",
  sort_by_direction: "desc",  # "desc"|"asc"
  limit:      50,
  offset:     0
)
puts stat.date      # => "2015-01-01"
stat.stats.each do |stat|
  metrics = stat.metrics
  puts metrics.blocks             # => 1
  puts metrics.bounce_drops       # => 1
  puts metrics.bounces            # => 1
  puts metrics.clicks             # => 1
  puts metrics.deferred           # => 1
  puts metrics.delivered          # => 1
  puts metrics.invalid_emails     # => 1
  puts metrics.opens              # => 1
  puts metrics.processed          # => 1
  puts metrics.requests           # => 1
  puts metrics.spam_report_drops  # => 1
  puts metrics.spam_reports       # => 1
  puts metrics.unique_clicks      # => 1
  puts metrics.unique_opens       # => 1
  puts metrics.unsubscribe_drops  # => 1
  puts metrics.unsubscribes       # => 1
end
puts stat.name      # => "user1"
puts stat.type      # => "subuser"
```

#### [Advanced Stats](https://sendgrid.com/docs/API_Reference/Web_API_v3/Stats/advanced.html)
##### GET
Gets email statistics by country and state/province.
```Ruby
stats = client.get_geo_stats(
  start_date: "2015-01-01"
)
stat = client.get_geo_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  country: "US"     # "US"|"CA"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.clicks             # => 1
    puts metrics.opens              # => 1
    puts metrics.unique_clicks      # => 1
    puts metrics.unique_opens       # => 1
  end
  puts stat.name      # => "US"
  puts stat.type      # => "country"
end
```

##### GET
Gets email statistics by device type.
```Ruby
stats = client.get_devices_stats(
  start_date: "2015-01-01"
)
stat = client.get_devices_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.opens              # => 1
    puts metrics.unique_opens       # => 1
  end
  puts stat.name      # => "Webmail"
  puts stat.type      # => "device"
end
```

##### GET
Gets email statistics by client type.
```Ruby
stats = client.get_clients_stats(
  start_date: "2015-01-01"
)
stat = client.get_clients_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.opens              # => 1
    puts metrics.unique_opens       # => 1
  end
  puts stat.name      # => "Gmail"
  puts stat.type      # => "client"
end
```

##### GET
Gets email statistics for a single client type.
```Ruby
stats = client.get_clients_type_stats(
  start_date: "2015-01-01",
  client_type: "phone"  # "phpne"|"tablet"|"webmail"|"desktop"
)
stat = client.get_clients_type_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  client_type: "phone"  # "phpne"|"tablet"|"webmail"|"desktop"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.opens              # => 1
    puts metrics.unique_opens       # => 1
  end
  puts stat.name      # => "Gmail"
  puts stat.type      # => "client"
end
```

##### GET
Gets email statistics by email service provider (ESP).
```Ruby
stats = client.get_esp_stats(
  start_date: "2015-01-01"
)
stats = client.get_esp_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  esps: "sss"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.blocks             # => 1
    puts metrics.bounces            # => 1
    puts metrics.clicks             # => 1
    puts metrics.deferred           # => 1
    puts metrics.delivered          # => 1
    puts metrics.drops              # => 1
    puts metrics.opens              # => 1
    puts metrics.spam_reports       # => 1
    puts metrics.unique_clicks      # => 1
    puts metrics.unique_opens       # => 1
  end
  puts stat.name      # => "Gmail"
  puts stat.type      # => "esp"
end
```

##### GET
Gets email statistics by browser.
```Ruby
stats = client.get_browsers_stats(
  start_date: "2015-01-01"
)
stats = client.get_browsers_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK,
  browsers: "Chrome"
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.clicks             # => 1
    puts metrics.unique_clicks      # => 1
  end
  puts stat.name      # => "Firefox"
  puts stat.type      # => "browser"
end
```

##### GET
Gets statistics for Parse Webhook usage.
```Ruby
stats = client.get_parse_stats(
  start_date: "2015-01-01"
)
stats = client.get_parse_stats(
  start_date: "2015-01-01",
  end_date:   "2015-01-02",
  aggregated_by: SendGrid4r::REST::Stats::AggregatedBy::WEEK
)
stats.each do |stat|
  puts stat.date      # => "2015-01-01"
  stat.stats.each do |stat|
    metrics = stat.metrics
    puts metrics.received           # => 1
  end
end
```

----
### Template Engine
#### [Templates](https://sendgrid.com/docs/API_Reference/Web_API_v3/Template_Engine/templates.html)
##### POST
Create a template
```Ruby
template = client.post_template("new_template_name")
puts template.id
puts template.name
puts template.versions            # => []
```

##### GET
Retrieve all templates.
```Ruby
templates = client.get_templates
templates.each do |template|
  puts template.id
  puts template.name
  template.versions.each do |ver|
    puts ver.id
    puts ver.template_id
    puts ver.active
    puts ver.name
    puts ver.updated_at
  end
end
```

##### GET
Retrieve a single template
```Ruby
template = client.get_template(template_id)
puts template.id
puts template.name
template.versions.each do |ver|
  puts ver.id
  puts ver.user_id
  puts ver.template_id
  puts ver.active
  puts ver.name
  puts ver.html_content
  puts ver.plain_content
  puts ver.subject
  puts ver.updated_at
end
```

##### PATCH
Edit a template.
```Ruby
template = client.patch_template(template_id, "edit_template_name")
puts template.id
puts template.name
puts template.versions
```

##### DELETE
Delete a template.
```Ruby
client.delete_template(template_id)
```

#### [Versions](https://sendgrid.com/docs/API_Reference/Web_API_v3/Template_Engine/versions.html)
##### POST
Create a new version
```Ruby
factory = SendGrid4r::VersionFactory.new
ver1 = factory.create("version1_name")
ver1 = client.post_version(template_id, ver1)
puts ver1.name          # => "version1_name"
puts ver1.subject       # => "<%subject%>"
puts ver1.html_content  # => "<%body%>"
puts ver1.plain_content # => "<%body%>"
puts ver1.active        # => 1

ver2 = factory.create("version2_name", "<%subject%> ver2", "<%body%> ver2", "<%body%> ver2", 1)
ver2 = client.post_version(template_id, ver2)
```

##### POST
Activate a version.
```Ruby
ver = client.activate_version(template_id, version_id)
puts ver.id
puts ver.template_id
puts ver.active
puts ver.name
puts ver.html_content
puts ver.plain_content
puts ver.subject
puts ver.updated_at
```

##### GET
Retrieve a specific version of template.
```Ruby
ver = client.get_version(template_id, version_id)
puts ver.id
puts ver.template_id
puts ver.active
puts ver.name
puts ver.html_content
puts ver.plain_content
puts ver.subject
puts ver.update_at
```

##### PATCH
Edit a version.
```Ruby
edit_ver = client.get_version(template_id, version_id)
edit_ver.name = "edit_version"
edit_ver.subject = "edit<%subject%>edit"
edit_ver.html_content = "edit<%body%>edit"
edit_ver.plain_content = "edit<%body%>edit"
edit_ver.active = 0
new_ver = client.patch_version(template_id, version_id, edit_ver)
puts new_ver.id
puts new_ver.template_id
puts new_ver.active
puts new_ver.name
puts new_ver.html_content
puts new_ver.plain_content
puts new_ver.subject
puts new_ver.update_at
```

##### DELETE
Delete a version.
```Ruby
client.delete_version(template_id, version_id)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid4r/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
