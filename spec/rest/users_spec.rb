# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::REST
  describe Users do
    describe 'integration test', :it do
      before do
        Dotenv.load
        @client = SendGrid4r::Client.new(api_key: ENV['SILVER_API_KEY'])
      end

      context 'without block call' do
        it '#get_user_profile' do
          profile = @client.get_user_profile
          expect(profile).to be_a(Users::Profile)
        end

        it '#patch_user_profile' do
          params = {}
          params['city'] = 'nakano'
          profile = @client.patch_user_profile(params: params)
          expect(profile).to be_a(Users::Profile)
        end

        it '#get_user_account' do
          account = @client.get_user_account
          expect(account).to be_a(Users::Account)
        end

        it '#get_user_email' do
          email = @client.get_user_email
          expect(email).to be_a(Users::Email)
        end

        it '#put_user_email' do
          pending('Access Forbidden')
          email = @client.put_user_email(email: 'test..example.com')
          expect(email).to be_a(Users::Email)
        end

        it '#get_user_username' do
          username = @client.get_user_username
          expect(username).to be_a(Users::Username)
        end

        it '#put_user_username' do
          pending('Access Forbidden')
          username = @client.put_user_username(username: 'abc')
          expect(username).to be_a(Users::Username)
        end

        it '#get_user_credits' do
          credits = @client.get_user_credits
          expect(credits).to be_a(Users::Credits)
        end

        it '#put_user_password' do
          pending('Access Forbidden')
          password = @client.put_user_password(
            new_password: '', old_password: ''
          )
          expect(password).to be_a(Users::Password)
        end
      end
    end

    describe 'unit test', :ut do
      let(:client) do
        SendGrid4r::Client.new(api_key: '')
      end

      let(:profile) do
        JSON.parse(
          '{'\
            '"address":"814 West Chapman Avenue",'\
            '"city":"Orange",'\
            '"company":"SendGrid",'\
            '"country":"US",'\
            '"first_name":"Test",'\
            '"last_name":"User",'\
            '"phone":"555-555-5555",'\
            '"state":"CA",'\
            '"website":"http://www.sendgrid.com",'\
            '"zip":"92868"'\
          '}'
        )
      end

      let(:account) do
        JSON.parse(
          '{'\
            '"type": "free",'\
            '"reputation": 99.7'\
          '}'
        )
      end

      let(:email) do
        JSON.parse(
          '{'\
            '"email": "test@example.com"'\
          '}'
        )
      end

      let(:username) do
        JSON.parse(
          '{'\
            '"username": "test_username",'\
            '"user_id": 1'\
          '}'
        )
      end

      let(:credits) do
        JSON.parse(
          '{'\
            '"remain": 200,'\
            '"total": 200,'\
            '"overage": 0,'\
            '"used": 0,'\
            '"last_reset": "2013-01-01",'\
            '"next_reset": "2013-02-01",'\
            '"reset_frequency": "monthly"'\
          '}'
        )
      end

      let(:password) do
        JSON.parse(
          '{'\
            '"new_password": "new_password",'\
            '"old_password": "old_password"'\
          '}'
        )
      end

      it '#get_user_profile' do
        allow(client).to receive(:execute).and_return(profile)
        actual = client.get_user_profile
        expect(actual).to be_a(Users::Profile)
      end

      it '#patch_user_profile' do
        allow(client).to receive(:execute).and_return(profile)
        params = {}
        params['city'] = 'nakano'
        actual = client.patch_user_profile(params: params)
        expect(actual).to be_a(Users::Profile)
      end

      it '#get_user_account' do
        allow(client).to receive(:execute).and_return(account)
        actual = client.get_user_account
        expect(actual).to be_a(Users::Account)
      end

      it 'creates profile instance' do
        actual = Users.create_profile(profile)
        expect(actual.address).to eq('814 West Chapman Avenue')
        expect(actual.city).to eq('Orange')
        expect(actual.company).to eq('SendGrid')
        expect(actual.first_name).to eq('Test')
        expect(actual.last_name).to eq('User')
        expect(actual.phone).to eq('555-555-5555')
        expect(actual.state).to eq('CA')
        expect(actual.website).to eq('http://www.sendgrid.com')
        expect(actual.zip).to eq('92868')
      end

      it 'creates account instance' do
        actual = Users.create_account(account)
        expect(actual.type).to eq('free')
        expect(actual.reputation).to eq(99.7)
      end

      it 'creates email instance' do
        actual = Users.create_email(email)
        expect(actual.email).to eq('test@example.com')
      end

      it 'creates username instance' do
        actual = Users.create_username(username)
        expect(actual.username).to eq('test_username')
        expect(actual.user_id).to eq(1)
      end

      it 'creates credits instance' do
        actual = Users.create_credits(credits)
        expect(actual.remain).to eq(200)
        expect(actual.total).to eq(200)
        expect(actual.overage).to eq(0)
        expect(actual.used).to eq(0)
        expect(actual.last_reset).to eq('2013-01-01')
        expect(actual.next_reset).to eq('2013-02-01')
        expect(actual.reset_frequency).to eq('monthly')
      end

      it 'creates password instance' do
        actual = Users.create_password(password)
        expect(actual.new_password).to eq('new_password')
        expect(actual.old_password).to eq('old_password')
      end
    end
  end
end
