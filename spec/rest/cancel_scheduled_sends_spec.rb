# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe SendGrid4r::REST::CancelScheduledSends do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @scheduled_sends = @client.get_scheduled_sends
        @scheduled_sends.each do |scheduled_send|
          @client.delete_scheduled_send(batch_id: scheduled_send.batch_id)
        end
      end

      context 'without block call' do
        it '#generate_batch_id' do
          scheduled_send = @client.generate_batch_id
          expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
          expect(scheduled_send.batch_id.length).to be > 0
        end

        it '#validate_batch_id' do
          batch_id = @client.generate_batch_id.batch_id
          scheduled_send = @client.validate_batch_id(batch_id: batch_id)
          expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
          expect(scheduled_send.batch_id).to eq(batch_id)
        end

        it '#post_scheduled_send' do
          batch_id = @client.generate_batch_id.batch_id
          scheduled_send = @client.post_scheduled_send(
            batch_id: batch_id, status: 'cancel'
          )
          expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
        end

        it '#get_scheduled_sends' do
          scheduled_sends = @client.get_scheduled_sends
          expect(scheduled_sends).to be_a(Array)
          scheduled_sends.each do |scheduled_send|
            expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
          end
        end

        it '#patch_scheduled_send' do
          batch_id = @client.generate_batch_id.batch_id
          expect do
            @client.patch_scheduled_send(batch_id: batch_id, status: 'pause')
          end.to raise_error(RestClient::ResourceNotFound)
        end

        it '#delete_scheduled_send' do
          scheduled_sends = @client.get_scheduled_sends
          scheduled_sends.each do |scheduled_send|
            @client.delete_scheduled_send(batch_id: scheduled_send.batch_id)
          end
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:scheduled_send) do
        JSON.parse(
          '{'\
            '"batch_id": "YOUR_BATCH_ID"'\
          '}'
        )
      end

      let(:scheduled_sends) do
        JSON.parse(
          '['\
            '{'\
              '"batch_id": "BATCH_ID_1",'\
              '"status": "cancel"'\
            '},'\
            '{'\
              '"batch_id": "BATCH_ID_2",'\
              '"status": "pause"'\
            '}'\
          ']'
        )
      end

      it '#generate_batch_id' do
        allow(client).to receive(:execute).and_return(scheduled_send)
        actual = client.generate_batch_id
        expect(actual).to be_a(CancelScheduledSends::ScheduledSend)
        expect(actual.batch_id).to eq('YOUR_BATCH_ID')
      end

      it '#validate_batch_id' do
        allow(client).to receive(:execute).and_return(scheduled_send)
        actual = client.validate_batch_id(batch_id: '')
        expect(actual).to be_a(CancelScheduledSends::ScheduledSend)
        expect(actual.batch_id).to eq('YOUR_BATCH_ID')
      end

      it '#post_scheduled_send' do
        allow(client).to receive(:execute).and_return(scheduled_send)
        actual = client.post_scheduled_send(batch_id: '', status: '')
        expect(actual).to be_a(CancelScheduledSends::ScheduledSend)
        expect(actual.batch_id).to eq('YOUR_BATCH_ID')
      end

      it '#get_scheduled_sends' do
        allow(client).to receive(:execute).and_return(scheduled_sends)
        actual = client.get_scheduled_sends
        expect(actual).to be_a(Array)
        actual.each do |scheduled_send|
          expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
        end
      end

      it '#patch_scheduled_send' do
        allow(client).to receive(:execute).and_return('')
        actual = client.patch_scheduled_send(batch_id: '', status: '')
        expect(actual).to eq('')
      end

      it '#delete_scheduled_send' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_scheduled_send(batch_id: '')
        expect(actual).to eq('')
      end

      it 'creates scheduled_sends instance' do
        actual = CancelScheduledSends.create_scheduled_sends(
          scheduled_sends
        )
        expect(actual).to be_a(Array)
        actual.each do |scheduled_send|
          expect(scheduled_send).to be_a(CancelScheduledSends::ScheduledSend)
          expect(actual[0].batch_id).to eq('BATCH_ID_1')
          expect(actual[0].status).to eq('cancel')
          expect(actual[1].batch_id).to eq('BATCH_ID_2')
          expect(actual[1].status).to eq('pause')
        end
      end

      it 'creates scheduled_send instance' do
        actual = CancelScheduledSends.create_scheduled_send(
          scheduled_send
        )
        expect(actual).to be_a(CancelScheduledSends::ScheduledSend)
        expect(actual.batch_id).to eq('YOUR_BATCH_ID')
      end
    end
  end
end
