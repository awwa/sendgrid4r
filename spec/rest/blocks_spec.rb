# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe SendGrid4r::REST::Blocks do
  describe 'integration test', :it do
    before do
      begin
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @emails = ['a1@block.com', 'a2@block.com', 'a3@block.com']
      rescue RestClient::ExceptionWithResponse => e
        puts e.inspect
        raise e
      end
    end

    context 'without block call' do
      it '#get_blocks' do
        begin
          start_time = Time.now - 60 * 60 * 24 * 365
          end_time = Time.now
          blocks = @client.get_blocks(
            start_time: start_time, end_time: end_time
          )
          expect(blocks).to be_a(Array)
          blocks.each do |block|
            expect(block).to be_a(SendGrid4r::REST::Blocks::Block)
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_blocks(delete_all: true)' do
        begin
          @client.delete_blocks(delete_all: true)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_blocks(emails: [])' do
        begin
          @client.delete_blocks(emails: @emails)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#get_block' do
        begin
          block = @client.get_block(email: @email)
          expect(block).to be_a(Array)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      it '#delete_block' do
        begin
          expect do
            @client.delete_block(email: 'a1@block.com')
          end.to raise_error(RestClient::ResourceNotFound)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end
    end
  end

  describe 'unit test', :ut do
    let(:client) do
      SendGrid4r::Client.new(api_key: '')
    end

    let(:blocks) do
      JSON.parse(
        '['\
          '{'\
            '"created": 1443651154,'\
            '"email": "user1@example.com",'\
            '"reason": "error dialing remote address: dial tcp '\
            '10.57.152.165:25: no route to host",'\
            '"status": "4.0.0"'\
          '}'\
        ']'
      )
    end

    let(:block) do
      JSON.parse(
        '{'\
          '"created": 1443651154,'\
          '"email": "user1@example.com",'\
          '"reason": "error dialing remote address: dial tcp '\
          '10.57.152.165:25: no route to host",'\
          '"status": "4.0.0"'\
        '}'\
      )
    end

    it '#get_blocks' do
      allow(client).to receive(:execute).and_return(blocks)
      actual = client.get_blocks
      expect(actual).to be_a(Array)
      actual.each do |block|
        expect(block).to be_a(SendGrid4r::REST::Blocks::Block)
      end
    end

    it '#delete_blocks(delete_all: true)' do
      allow(client).to receive(:execute).and_return('')
      client.delete_blocks(delete_all: true)
    end

    it '#delete_blocks(emails: [])' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_blocks(emails: [])
      expect(actual).to eq('')
    end

    it '#get_block' do
      allow(client).to receive(:execute).and_return(blocks)
      actual = client.get_block(email: '')
      expect(actual).to be_a(Array)
      actual.each do |block|
        expect(block).to be_a(SendGrid4r::REST::Blocks::Block)
      end
    end

    it '#delete_block' do
      allow(client).to receive(:execute).and_return('')
      actual = client.delete_block(email: '')
      expect(actual).to eq('')
    end

    it 'creates blocks instance' do
      actual = SendGrid4r::REST::Blocks.create_blocks(blocks)
      expect(actual).to be_a(Array)
      actual.each do |subuser|
        expect(subuser).to be_a(SendGrid4r::REST::Blocks::Block)
      end
    end

    it 'creates block instance' do
      actual = SendGrid4r::REST::Blocks.create_block(block)
      expect(actual).to be_a(SendGrid4r::REST::Blocks::Block)
      expect(actual.created).to eq(Time.at(1443651154))
      expect(actual.email).to eq('user1@example.com')
      expect(actual.reason).to eq(
        'error dialing remote address: dial tcp '\
        '10.57.152.165:25: no route to host'
      )
      expect(actual.status).to eq('4.0.0')
    end
  end
end
