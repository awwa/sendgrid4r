# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

module SendGrid4r::CLI
  describe SG do
    describe 'integration test', :it do
      before do
        Dotenv.load
      end

      it '#api_key subcommand' do
        args = ['api_key']
        SG.start(args)
      end

      it '#cancel_schedule subcommand' do
        args = ['cancel_schedule']
        SG.start(args)
      end

      it '#ip subcommand' do
        args = ['ip']
        SG.start(args)
      end

      it '#ipam subcommand' do
        args = ['ipam']
        SG.start(args)
      end

      it '#settings subcommand' do
        args = ['settings']
        SG.start(args)
      end

      it '#subuser subcommand' do
        args = ['subuser']
        SG.start(args)
      end

      it '#suppression subcommand' do
        args = ['suppression']
        SG.start(args)
      end

      it '#template subcommand' do
        args = ['template']
        SG.start(args)
      end

      it '#webhook subcommand' do
        args = ['webhook']
        SG.start(args)
      end

      it '#whitelabel subcommand' do
        args = ['whitelabel']
        SG.start(args)
      end

      it '#category subcommand' do
        args = ['category']
        SG.start(args)
      end

      it '#user subcommand' do
        args = ['user']
        SG.start(args)
      end

      it '#campaign subcommand' do
        args = ['campaign']
        SG.start(args)
      end

      it '#mail subcommand' do
        args = ['mail']
        SG.start(args)
      end
    end
  end
end
