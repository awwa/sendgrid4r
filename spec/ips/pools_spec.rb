# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe 'SendGrid4r::REST::Ips::Pools' do
  before :all do
    Dotenv.load
    @client = SendGrid4r::Client.new(
      ENV['SILVER_SENDGRID_USERNAME'], ENV['SILVER_SENDGRID_PASSWORD'])
    @pool_name = 'pool_test'
    @pool_edit = 'pool_edit'
  end

  context 'if account is silver' do
    it 'is normal' do
      # clean up test env
      pools = @client.get_pools
      expect(pools.length >= 0).to eq(true)
      pools.each do |pool|
        if pool.name == @pool_name || pool.name == @pool_edit
          @client.delete_pool(pool.name)
        end
      end
      # post a pool
      new_pool = @client.post_pool(@pool_name)
      expect(@pool_name).to eq(new_pool.name)
      # put the pool
      edit_pool = @client.put_pool(@pool_name, @pool_edit)
      expect(@pool_edit).to eq(edit_pool.name)
      # get the pool
      pool = @client.get_pool(@pool_edit)
      expect(SendGrid4r::REST::Ips::Pools::Pool).to be(pool.class)
      # delete the pool
      @client.delete_pool(pool.pool_name)
      expect { @client.get_pool(pool.name) }
      ips = @client.get_ips
      expect(ips.length).to be(1)
      expect(ips[0].class).to be(SendGrid4r::REST::Ips::Addresses::Address)
      expect(
        @client.get_ip(ips[0].ip).class
      ).to be(SendGrid4r::REST::Ips::Addresses::Address)
    end
  end
end
