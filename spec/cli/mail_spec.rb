# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::CLI
  describe Mail do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#send with mandatory params' do
        args = [
          'send',
          '--api-key', ENV['SILVER_API_KEY'],
          '--to', "email:#{ENV['MAIL']}",
          '--from', "email:#{ENV['FROM']}",
          '--content', "type:text/plain,value:これはテキスト\nThis is plain",
          '--subject', 'v3コマンドラインMail'
        ]
        Mail.start(args)
      end

      it '#send with HTML mail' do
        args = [
          'send',
          '--api-key', ENV['SILVER_API_KEY'],
          '--to', "email:#{ENV['MAIL']}", 'name:宛先 太郎',
          '--from', "email:#{ENV['FROM']}", 'name:送信者 次郎',
          '--content', "type:text/plain,value:これはテキスト\nThis is plain",
          'type:text/html,value:<p>This is HTML</p><p>これはHTML</p>',
          '--subject', 'v3コマンドラインMail'
        ]
        Mail.start(args)
      end
    end
  end
end
