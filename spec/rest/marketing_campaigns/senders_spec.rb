# encoding: utf-8
require File.dirname(__FILE__) + '/../../spec_helper'

module SendGrid4r::REST::MarketingCampaigns
  describe SendGrid4r::REST::MarketingCampaigns do
    describe 'integration test', :it do
      before do
        begin
          Dotenv.load
          @client = SendGrid4r::Client.new(api_key: ENV['API_KEY'])
          @name1 = 'sender1'
          @name2 = 'sender2'

          # celan up test env
          senders = @client.get_senders
          senders.each do |sender|
            next if sender.nickname != @name1 && sender.nickname != @name2
            @client.delete_sender(sender_id: sender.id)
          end
          # post a sender
          @from = SendGrid4r::Factory::CampaignFactory.new.create_address(
            email: ENV['MAIL'], name: 'Example INC'
          )
          @reply_to = SendGrid4r::Factory::CampaignFactory.new.create_address(
            email: 'replyto@example.com', name: 'Example INC'
          )
          @params1 = SendGrid4r::Factory::CampaignFactory.new.create_sender(
            nickname: @name1, from: @from, reply_to: @reply_to,
            address: '123 Elm St.', address_2: 'Apt. 456',
            city: 'Denver', state: 'Colorado', zip: '80202',
            country: 'United States'
          )
          @sender1 = @client.post_sender(params: @params1)
        rescue RestClient::ExceptionWithResponse => e
          puts e.inspect
          raise e
        end
      end

      context 'without block call' do
        it '#post_sender' do
          @params2 = SendGrid4r::Factory::CampaignFactory.new.create_sender(
            nickname: @name2, from: @from, reply_to: @reply_to,
            address: '123 Elm St.', address_2: 'Apt. 456',
            city: 'Denver', state: 'Colorado', zip: '80202',
            country: 'United States'
          )
          sender = @client.post_sender(params: @params2)
          expect(sender).to be_a(Sender)
        end

        it '#get_senders' do
          senders = @client.get_senders
          expect(senders).to be_a(Array)
          senders.each do |sender|
            expect(sender).to be_a(Sender)
          end
        end

        it '#patch_sender' do
          @params1.address = '456 Test St.'
          sender = @client.patch_sender(
            sender_id: @sender1.id, params: @params1
          )
          expect(sender).to be_a(Sender)
          expect(sender.address).to eq('456 Test St.')
        end

        it '#delete_sender' do
          @client.delete_sender(sender_id: @sender1.id)
        end

        it '#resend_sender_verification' do
          @client.resend_sender_verification(sender_id: @sender1.id)
        end

        it '#get_sender' do
          sender = @client.get_sender(sender_id: @sender1.id)
          expect(sender).to be_a(Sender)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:sender) do
        JSON.parse(
          '{'\
            '"id": 1,'\
            '"nickname": "My Sender ID",'\
            '"from": {'\
              '"email": "from@example.com",'\
              '"name": "Example INC"'\
            '},'\
            '"reply_to": {'\
              '"email": "replyto@example.com",'\
              '"name": "Example INC"'\
            '},'\
            '"address": "123 Elm St.",'\
            '"address_2": "Apt. 456",'\
            '"city": "Denver",'\
            '"state": "Colorado",'\
            '"zip": "80202",'\
            '"country": "United States",'\
            '"verified":{'\
              '"status":false,"reason":null'\
            '},'\
            '"updated_at": 1449872165,'\
            '"created_at": 1449872165,'\
            '"locked": false'\
          '}'
        )
      end

      let(:senders) do
        JSON.parse(
          '['\
            '{'\
              '"id":1,'\
              '"nickname":"My Sender ID",'\
              '"from":{'\
                '"email":"from@example.com","name":"Example INC"'\
              '},'\
              '"reply_to":{'\
                '"email":"replyto@example.com","name":"Example INC"'\
              '},'\
              '"address":"123 Elm St.",'\
              '"address_2":"Apt. 456",'\
              '"city":"Denver",'\
              '"state":"Co",'\
              '"zip":"80202",'\
              '"country":"United States",'\
              '"verified":{'\
                '"status":false,"reason":null'\
              '},'\
              '"updated_at":1464187035,'\
              '"created_at":1464187035,'\
              '"locked":false'\
            '}'\
          ']'
        )
      end

      it '#post_sender' do
        allow(client).to receive(:execute).and_return(sender)
        actual = client.post_sender(params: nil)
        expect(actual).to be_a(Sender)
      end

      it '#get_senders' do
        allow(client).to receive(:execute).and_return(senders)
        actual = client.get_senders
        expect(actual).to be_a(Array)
        actual.each { |sender| expect(sender).to be_a(Sender) }
      end

      it '#patch_sender' do
        allow(client).to receive(:execute).and_return(sender)
        actual = client.patch_sender(sender_id: 0, params: nil)
        expect(actual).to be_a(Sender)
      end

      it '#delete_sender' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_sender(sender_id: 0)
        expect(actual).to eq('')
      end

      it '#resend_sender_verification' do
        allow(client).to receive(:execute).and_return('')
        actual = client.resend_sender_verification(sender_id: 0)
        expect(actual).to eq('')
      end

      it '#get_sender' do
        allow(client).to receive(:execute).and_return(sender)
        actual = client.get_sender(sender_id: 0)
        expect(actual).to be_a(Sender)
      end

      it 'creates sender instance' do
        actual = SendGrid4r::REST::MarketingCampaigns.create_sender(sender)
        expect(actual).to be_a(Sender)
        expect(actual.id).to eq(1)
        expect(actual.nickname).to eq('My Sender ID')
        expect(actual.from.email).to eq('from@example.com')
        expect(actual.from.name).to eq('Example INC')
        expect(actual.reply_to.email).to eq('replyto@example.com')
        expect(actual.reply_to.name).to eq('Example INC')
        expect(actual.address).to eq('123 Elm St.')
        expect(actual.address_2).to eq('Apt. 456')
        expect(actual.city).to eq('Denver')
        expect(actual.state).to eq('Colorado')
        expect(actual.zip).to eq('80202')
        expect(actual.country).to eq('United States')
        expect(actual.verified.status).to eq(false)
        expect(actual.verified.reason).to eq(nil)
        expect(actual.updated_at).to eq(Time.at(1449872165))
        expect(actual.created_at).to eq(Time.at(1449872165))
        expect(actual.locked).to eq(false)
      end

      it 'creates senders instance' do
        actual = SendGrid4r::REST::MarketingCampaigns.create_senders(senders)
        expect(actual).to be_a(Array)
        sender = actual[0]
        expect(sender.id).to eq(1)
        expect(sender.nickname).to eq('My Sender ID')
        expect(sender.from.email).to eq('from@example.com')
        expect(sender.from.name).to eq('Example INC')
        expect(sender.reply_to.email).to eq('replyto@example.com')
        expect(sender.reply_to.name).to eq('Example INC')
        expect(sender.address).to eq('123 Elm St.')
        expect(sender.address_2).to eq('Apt. 456')
        expect(sender.city).to eq('Denver')
        expect(sender.state).to eq('Co')
        expect(sender.zip).to eq('80202')
        expect(sender.country).to eq('United States')
        expect(sender.verified.status).to eq(false)
        expect(sender.verified.reason).to eq(nil)
        expect(sender.updated_at).to eq(Time.at(1464187035))
        expect(sender.created_at).to eq(Time.at(1464187035))
        expect(sender.locked).to eq(false)
      end
    end
  end
end
