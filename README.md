# Sendgrid4r

This gem allows you to quickly and easily access to SendGrid Web API v3 for Ruby.
See [api reference](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html) for more detail

[![Build Status](https://travis-ci.org/awwa/sendgrid_template_engine_ruby.svg?branch=master)](https://travis-ci.org/awwa/sendgrid_template_engine_ruby.svg?branch=master)

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

#### Groups

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

##### POST
Create a new suppression group.
```Ruby
new_group = client.post_group("group_name", "group_desc")
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

#### Suppressions

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

#### Global Suppressions

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
### IP Management

#### IP Addresses

##### GET
See a list of all IPs and the IPs, including warm up status and pools.
```Ruby
ips = client.get_ips
ips.each{|ip|
  puts ip.ip            # => "xxx.xxx.xxx.xxx"
  puts ip.pools         # => ["new_test5"]
  puts ip.warmup        # => true/false
  puts ip.start_date    # => 1409616000
}
```

##### GET
See which pools an IP address belongs to.
```Ruby
ip = client.get_ip("xxx.xxx.xxx.xxx")
puts ip.ip            # => "xxx.xxx.xxx.xxx"
puts ip.pools         # => ["new_test5"]
puts ip.warmup        # => true/false
```

##### POST
Add an IP to a pool.
```Ruby
ip = client.post_ip_to_pool("pool_name", "xxx.xxx.xxx.xxx")
puts ip.ip            # => "xxx.xxx.xxx.xxx"
puts ip.pool_name     # => "new_test5"
```

##### DELETE
Remove an IP address from a pool.
```Ruby
client.delete_ip_from_pool("pool_name", "xxx.xxx.xxx.xxx")
```

#### IP Pools

##### GET
List all IP pools.
```Ruby
pools = client.get_pools
puts pools.inspect    # => ["marketing","transactional"]
```

##### POST
Create an IP pool.
```Ruby
pool = client.post_pool("name")
puts pool.name        # => "name"
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
client.put_pool("name", "new_name")
puts pool.name        # => "name"
puts pool.ips.inspect # => ["167.89.21.3"]
```

##### DELETE
Delete an IP pool.
```Ruby
client.delete_pool("name")
```

#### IP Warmup

##### GET
Get all IPs that are currently warming up.
```Ruby
warmup_ips = client.get_warmup_ips
warmup_ips.each{|warmup_ip|
  puts warmup_ip.ip         # => "xxx.xxx.xxx.xxx"
  puts warmup_ip.start_date # => 1409616000
}
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
client.post_warmup_ip("xxx.xxx.xxx.xxx")
```

##### DELETE
Remove an IP from warmup.
```Ruby
client.delete_warmup_ip("xxx.xxx.xxx.xxx")
```

----
### Settings

#### Enforced TLS

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
client.patch_enforced_tls(enforced_tls)
```

----
### Template Engine

#### Templates

##### GET
Retrieve all templates.
```Ruby
templates = client.get_templates
templates.each {|template|
  puts template.id
  puts template.name
  template.versions.each {|ver|
    puts ver.id
    puts ver.template_id
    puts ver.active
    puts ver.name
    puts ver.updated_at
  }
}
```

##### GET
Retrieve a single template
```Ruby
template = client.get_template(template_id)
puts template.id
puts template.name
template.versions.each {|ver|
  puts ver.id
  puts ver.template_id
  puts ver.active
  puts ver.name
  puts ver.updated_at
}
```

##### POST
Create a template
```Ruby
client.post_template("new_template_name")
```

##### PATCH
Edit a template.
```Ruby
client.patch_template(template_id, "edit_template_name")
```

##### DELETE
Delete a template.
```Ruby
client.delete_template(template_id)
```

#### Versions

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
client.activate_version(template_id, version_id)
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
client.patch_version(template_id, version_id, edit_ver)
```

##### DELETE
Delete a version.
```Ruby
client.delete_version(template_id, version_id)
```

----
### Categories

#### Categories

##### GET
Retrieve all categories.
```Ruby
categories = client.get_categories
categories.each {|category|
  puts category.category
}
```

Retrieve some categories that have the name "Newsletter" 2 items from index 40.
```Ruby
categories = client.get_categories("Newsletter", nil, nil)
categories.each {|category|
  puts category.category
}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid4r/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
