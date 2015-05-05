# Sendgrid4r

**This gem is BETA yet. The interfaces will be changed often.**

This gem allows you to quickly and easily access to SendGrid Web API v3 for Ruby.
See [api reference](https://sendgrid.com/docs/API_Reference/Web_API_v3/index.html) for more detail

[![Build Status](https://travis-ci.org/awwa/sendgrid4r.svg?branch=master)](https://travis-ci.org/awwa/sendgrid4r)

# [Documentation](https://github.com/awwa/sendgrid4r/wiki)

# Test

## Unit Test
The Unit test do not access SendGrid API.
```
rspec --tag ut
```

## Integration Test
You need to copy .env.example file to .env. Then edit the .env file.
```
cp .env.example .env
vi .env
```
Integration test access SendGrid API and parse the response.
```
rspec --tag it
```

## All Test
```
rspec
```

# Contributing

1. Fork it ( https://github.com/[my-github-username]/sendgrid4r/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
