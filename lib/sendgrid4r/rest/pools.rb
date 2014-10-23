# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Ips
      module Pools

        include SendGrid4r::REST::Request

        def get_pools
          get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools")
        end

        def post_pool(name)
          params = Hash.new
          params["name"] = name
          Pool.create(post(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools", params))
        end

        def get_pool(name)
          Pool.create(get(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}"))
        end

        def put_pool(name, new_name)
          params = Hash.new
          params["name"] = new_name
          Pool.create(put(@auth, "#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}", params))
        end

        def delete_pool(name)
          delete(@auth,"#{SendGrid4r::Client::BASE_URL}/ips/pools/#{name}")
        end

      end

      class Pool

        attr_accessor :name, :ips

        def self.create(value)
          obj = Pool.new
          obj.name = value["name"]
          obj.ips = value["ips"]
          obj
        end

      end
    end
  end
end
