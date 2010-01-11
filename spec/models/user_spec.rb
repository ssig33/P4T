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
end
