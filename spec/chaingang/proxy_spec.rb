require 'spec_helper'

describe ChainGang do
  describe "##find" do
    context "when called with no arguments" do
      it "should return a ChainGang::Proxy" do
        Client.find.class.should == ChainGang::Proxy
      end

      it "should set the __client to the calling class" do
        Client.find.__client.should == Client
      end
    end

    context "when called with an argument" do
      it "should return a ChainGang::proxy" do
        @proxy = Client.find 1
        @proxy.class.should == ChainGang::Proxy
      end

      it "should set the __find_scope to the argument" do
        Client.find('hi').__find_scope.should == 'hi'
      end
    end
  end

  describe
end
