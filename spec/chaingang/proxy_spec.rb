require 'spec_helper'

describe ChainGang do
  describe "##find" do
    context "when called with no arguments" do
      it "should return a ChainGang::Proxy" do
        Client.find.class.should == ChainGang::Proxy
      end

      it "should set the @client to the calling class" do
        Client.find.send(:value, :client).should == Client
      end

      it "should default @find_scope to :all" do
        Client.find.send(:value, :find_scope).should == :all
      end
    end

    context "when called with an argument" do
      it "should return the result" do
        Dupe.create :client, :name => 'test 1'
        @result = Client.find 1
        @result.name.should == 'test 1' 
      end
    end
  end

  describe ChainGang::Proxy do
    before do
      @proxy = Client.find
    end

    describe "#all" do
      it "should set @find_scope to :all" do
        @proxy.all.send(:value, :find_scope).should == :all
      end
    end

    describe "#first" do
      it "should set @find_scope to :first" do
        @proxy.first.send(:value, :find_scope).should == :first
      end
    end

    describe "#last" do
      it "should set @find_scope to :last" do
        @proxy.last.send(:value, :find_scope).should == :last
      end
    end

    describe "#one" do
      it "should set @find_scope to :one" do
        @proxy.one.send(:value, :find_scope).should == :one
      end
    end

    describe "#from" do
      it "should require an argument" do
        proc { @proxy.from }.should raise_exception
      end
      
      it "should set @from to the argument" do
        @proxy.from("/testing").send(:value, :from).should == "/testing" 
      end
    end

    describe "#where" do
      it "should do nothing and return the proxy" do
        @proxy.where.should == @proxy
      end
    end

    describe "#and" do
      it "should do nothing and return the proxy" do
        @proxy.and.should == @proxy
      end
    end

    describe "#method_missing" do
      before do
        @proxy = Client.find
      end

      it "should allow you to set any parameter" do
        @proxy.food("taco").send(:value, :params)[:food].should == "taco"
      end
    end

    describe "#execute" do
      it "should call the #find_without_chaingang method on the original client class" do
        Client.should_receive(:find_without_chaingang).with(:all, :from => "/poo", :params => { :hi => 'hi', :yes => 'no' }).and_return([])
        Client.find.from("/poo").where.hi("hi").and.yes("no").execute
      end
    end
    
    describe "#each" do
      before do
        Dupe.stub 10, :clients
        @proxy = Client.find.all
      end

      it "should call #execute" do
        @proxy.should_receive(:execute).and_return([])
        @proxy.each {}
      end
    end
  end
end
