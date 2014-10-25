# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require "sendgrid4r/rest/request"

module SendGrid4r
  module REST
    module Settings
      module EnforcedTls

        include SendGrid4r::REST::Request

        def get_enforced_tls
          response = get(@auth, "#{SendGrid4r::Client::BASE_URL}/user/settings/enforced_tls")
          EnforcedTls.create(response)
        end

        def patch_enforced_tls(params)
          response = patch(@auth, "#{SendGrid4r::Client::BASE_URL}/user/settings/enforced_tls", params.to_hash)
          EnforcedTls.create(response)
        end

        class EnforcedTls

          attr_accessor :require_tls, :require_valid_cert

          def self.create(value)
            obj = EnforcedTls.new
            obj.require_tls = value["require_tls"]
            obj.require_valid_cert = value["require_valid_cert"]
            obj
          end

          def to_hash
            hash = Hash.new
            hash["require_tls"]         = @require_tls        if @require_tls != nil
            hash["require_valid_cert"]  = @require_valid_cert if @require_valid_cert != nil
            hash
          end

        end

      end
    end
  end
end
