# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Request do
    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      it '#process_array_params with array' do
        actual = client.process_array_params(%w(a b c))
        expect(actual).to eq('a,b,c')
      end

      it '#process_array_params with string' do
        actual = client.process_array_params('abc')
        expect(actual).to eq('abc')
      end

      it '#process_url_params with nil' do
        actual = client.process_url_params('http://aaa.bbb/', nil)
        expect(actual).to eq('http://aaa.bbb/')
      end

      it '#process_url_params with hash' do
        actual = client.process_url_params(
          'http://aaa.bbb/', ccc: :c1, ddd: :d1
        )
        expect(actual).to eq('http://aaa.bbb/?ccc=c1&ddd=d1')
      end

      it '#process_url_params with array of hash' do
        actual = client.process_url_params(
          'http://aaa.bbb/', [{ ccc: :c1 }, { ccc: :c2, ddd: :d3 }]
        )
        expect(actual).to eq('http://aaa.bbb/?ccc=c1&ccc=c2&ddd=d3')
      end
    end
  end
end
