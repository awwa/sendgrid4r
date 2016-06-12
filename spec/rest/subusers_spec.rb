# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Subusers do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
        @username1 = ENV['SUBUSER1']
        @username2 = ENV['SUBUSER2']
        @username3 = ENV['SUBUSER3']
        @email1 = ENV['MAIL']
        @password1 = ENV['PASS']
        @ip = @client.get_ips[0].ip
        # celan up test env
        subusers = @client.get_subusers
        count1 = subusers.count { |subuser| subuser.username == @username1 }
        @client.delete_subuser(username: @username1) unless count1 == 0
        count2 = subusers.count { |subuser| subuser.username == @username2 }
        @client.delete_subuser(username: @username2) unless count2 == 0
        count3 = subusers.count { |subuser| subuser.username == @username3 }
        @client.delete_subuser(username: @username3) unless count3 == 0
        # create a subuser
        @subuser3 = @client.post_subuser(
          username: @username3,
          email: @email1,
          password: @password1,
          ips: [@ip]
        )
      end

      context 'without block call' do
        it '#get_subusers' do
          subusers = @client.get_subusers(limit: 100, offset: 0)
          expect(subusers).to be_a(Array)
          subusers.each do |subuser|
            expect(subuser).to be_a(Subusers::Subuser)
          end
        end

        it '#post_subuser' do
          expect(@subuser3).to be_a(Subusers::Subuser)
          expect(@subuser3.username).to eq(@username3)
          expect(@subuser3.email).to eq(@email1)
        end

        it '#patch_subuser' do
          @client.patch_subuser(username: @username3, disabled: true)
          @client.patch_subuser(username: @username3, disabled: false)
        end

        it '#delete_subuser' do
          @client.delete_subuser(username: @username3)
        end

        # TODO
        it '#get_subuser_monitor' do
          monitor = @client.get_subuser_monitor(
            username: @username3, email: @email1, frequency: 10
          )
          expect(monitor).to be_a(Subusers::Monitor)
        end

        it '#post_subuser_monitor' do
          monitor = @client.post_subuser_monitor(
            username: @username3, email: @email1, frequency: 10
          )
          expect(monitor).to be_a(Subusers::Monitor)
        end

        it '#put_subuser_monitor' do
          @client.post_subuser_monitor(
            username: @username3, email: @email1, frequency: 10
          )
          monitor = @client.put_subuser_monitor(
            username: @username3, email: @email1, frequency: 10
          )
          expect(monitor).to be_a(Subusers::Monitor)
        end

        it '#delete_subuser_monitor' do
          @client.post_subuser_monitor(
            username: @username3, email: @email1, frequency: 10
          )
          @client.delete_subuser_monitor(username: @username3)
        end

        it '#get_subuser_reputation' do
          params = []
          params.push(@username3)
          subusers = @client.get_subuser_reputation(usernames: params)
          expect(subusers).to be_a(Array)
          subusers.each do |subuser|
            expect(subuser).to be_a(Subusers::Subuser)
          end
        end

        it '#put_subuser_assigned_ips' do
          subuser = @client.put_subuser_assigned_ips(
            username: @username3, ips: [@ip]
          )
          expect(subuser.ips).to be_a(Array)
          subuser.ips.each do |ip|
            expect(ip).to be_a(String)
          end
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:subusers) do
        '['\
          '{'\
            '"id": 1,'\
            '"username": "Test@example.com",'\
            '"email": "Test@example.com"'\
          '},'\
          '{'\
            '"id": 2,'\
            '"username": "John@example.com",'\
            '"email": "John@example.com"'\
          '}'\
        ']'
      end

      let(:subuser) do
        '{'\
          '"username": "John@example.com",'\
          '"email": "John@example.com",'\
          '"password": "johns_password",'\
          '"ips": ['\
            '"1.1.1.1",'\
            '"2.2.2.2"'\
          '],'\
          '"disabled": false'\
        '}'
      end

      let(:ips) do
        '{'\
          '"ips": ['\
            '"127.0.0.1",'\
            '"127.0.0.2"'\
          ']'\
        '}'
      end

      let(:monitor) do
        '{'\
          '"email": "test@example.com",'\
          '"frequency": 500'\
        '}'
      end

      it '#get_subusers' do
        allow(client).to receive(:execute).and_return(subusers)
        actual = client.get_subusers(limit: 0, offset: 0, username: 'aaa')
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(Subusers::Subuser)
        end
      end

      it '#post_subuser' do
        allow(client).to receive(:execute).and_return(subuser)
        actual = client.post_subuser(
          username: '', email: '', password: '', ips: []
        )
        expect(actual).to be_a(Subusers::Subuser)
      end

      it '#patch_subuser' do
        allow(client).to receive(:execute).and_return(subuser)
        actual = client.patch_subuser(username: '', disabled: true)
        expect(actual).to be_a(Subusers::Subuser)
      end

      it '#delete_subuser' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_subuser(username: '')
        expect(actual).to eq('')
      end

      it '#get_subuser_monitor' do
        allow(client).to receive(:execute).and_return(monitor)
        actual = client.get_subuser_monitor(
          username: '', email: '', frequency: 1
        )
        expect(actual).to be_a(Subusers::Monitor)
      end

      it '#post_subuser_monitor' do
        allow(client).to receive(:execute).and_return(monitor)
        actual = client.post_subuser_monitor(
          username: '', email: '', frequency: 1
        )
        expect(actual).to be_a(Subusers::Monitor)
      end

      it '#put_subuser_monitor' do
        allow(client).to receive(:execute).and_return(monitor)
        actual = client.put_subuser_monitor(
          username: '', email: '', frequency: 1
        )
        expect(actual).to be_a(Subusers::Monitor)
      end

      it '#delete_subuser_monitor' do
        allow(client).to receive(:execute).and_return('')
        actual = client.delete_subuser_monitor(username: '')
        expect(actual).to eq('')
      end

      it '#get_subuser_reputation' do
        allow(client).to receive(:execute).and_return(subusers)
        actual = client.get_subuser_reputation(usernames: [])
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(Subusers::Subuser)
        end
      end

      it '#put_subuser_assigned_ips' do
        allow(client).to receive(:execute).and_return(subuser)
        actual = client.put_subuser_assigned_ips(username: '', ips: [])
        expect(actual).to be_a(Subusers::Subuser)
      end

      it 'creates subusers instance' do
        actual = Subusers.create_subusers(JSON.parse(subusers))
        expect(actual).to be_a(Array)
        actual.each do |subuser|
          expect(subuser).to be_a(Subusers::Subuser)
        end
      end

      it 'creates subuser instance' do
        actual = Subusers.create_subuser(JSON.parse(subuser))
        expect(actual).to be_a(Subusers::Subuser)
        expect(actual.username).to eq('John@example.com')
        expect(actual.email).to eq('John@example.com')
        expect(actual.password).to eq('johns_password')
        actual.ips do |ip|
          expect(ip).to be_a(String)
        end
        expect(actual.disabled).to eq(false)
      end

      it 'creates monitor instance' do
        actual = Subusers.create_monitor(JSON.parse(monitor))
        expect(actual).to be_a(Subusers::Monitor)
        expect(actual.email).to eq('test@example.com')
        expect(actual.frequency).to eq(500)
      end
    end
  end
end
