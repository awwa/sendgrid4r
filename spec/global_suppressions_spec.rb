# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "SendGrid4r::REST::Asm::GlobalSuppressions" do

  before :all do
    Dotenv.load
    @email1 = "test1@test.com"
    @email2 = "test2@test.com"
    @email3 = "test3@test.com"
  end

  context "normal" do
    it "is normal" do

      begin
        client = SendGrid4r::Client.new(ENV["SENDGRID_USERNAME"], ENV["SENDGRID_PASSWORD"])
        # celan up test env
        client.delete_global_suppressed_email(@email1)
        client.delete_global_suppressed_email(@email2)
        client.delete_global_suppressed_email(@email3)
        # post recipient emails to the global suppression group
        suppressed_emails = client.post_global_suppressed_emails([@email1, @email2, @email3])
        expect(suppressed_emails.length).to eq(3)
        expect(suppressed_emails[0]).to eq(@email1)
        expect(suppressed_emails[1]).to eq(@email2)
        expect(suppressed_emails[2]).to eq(@email3)
        # get the recipient emails
        actual_email1 = client.get_global_suppressed_email(@email1)
        actual_email2 = client.get_global_suppressed_email(@email2)
        actual_email3 = client.get_global_suppressed_email(@email3)
        actual_notexist = client.get_global_suppressed_email("notexist")
        expect(actual_email1).to eq(@email1)
        expect(actual_email2).to eq(@email2)
        expect(actual_email3).to eq(@email3)
        expect(actual_notexist).to eq(nil)
        # delete the suppressed email
        expect(client.delete_global_suppressed_email(@email1)).to eq("")
        expect(client.delete_global_suppressed_email(@email2)).to eq("")
        expect(client.delete_global_suppressed_email(@email3)).to eq("")
      rescue => ex
        puts ex.inspect
        raise ex
      end

    end
  end

end
