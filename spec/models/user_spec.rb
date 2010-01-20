require 'spec_helper'

describe User do
  fixtures :users

  describe "when find by ID" do
    describe "when use valid ID" do
      it "should find user instance" do
        User.find_by_id(1).id.should == 1
      end
    end #use valid ID
  end #find by ID

  describe "when create oauth consumer" do
    it "should create oauth consumer" do
      User.oauth_consumer.secret.should == OAuth::Consumer.new(CONSUMER, CONSUMER_SECRET, { :site => "http://twitter.com" }).secret
    end
  end #create oauth consumer

  describe "when get request token" do
    it "should get request token" do
      User.get_request_token.params["oauth_callback_confirmed"].should == OAuth::Consumer.new(CONSUMER, CONSUMER_SECRET, { :site => "http://twitter.com" }).get_request_token(:oauth_callback => "http://#{SITE_DOMAIN}/session/oauth_callback").params["oauth_callback_confirmed"]
    end
  end #get request token
end
