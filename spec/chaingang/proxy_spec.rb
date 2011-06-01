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
      it "should return a ChainGang::Proxy" do
        Client.find(:first).class.should == ChainGang::Proxy
      end

      it "should set the @client to the calling class" do
        Client.find(1).send(:value, :client).should == Client
      end

      it "should set @find_scope to the argument" do
        Client.find(1).send(:value, :find_scope).should == 1
      end
    end
  end

  describe ChainGang::Proxy do
    before do
      @proxy = Client.find
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

      it "should set a parameter when you call a method that ends with a question mark and has exactly one argument" do
        @proxy.food?("taco").send(:value, :params)[:food].should == "taco"
      end

      it "should proxy the method to the executed result otherwise" do
        Dupe.stub 5, :clients
        @proxy.count.should == 5
      end
    end

    describe "#execute" do
      it "should call the #find_without_chaingang method on the original client class" do
        Client.should_receive(:find_without_chaingang).with(:all, :from => "/poo", :params => { :hi => 'hi', :yes => 'no' }).and_return([])
        Client.find.from("/poo").where.hi?("hi").and.yes?("no").execute
      end
    end

    describe "#param?" do
      before do
        @proxy = Client.find
      end

      it "should require two arguments: param name and param value" do
        proc { @proxy.param?                            }.should     raise_exception 
        proc { @proxy.param? :param_name                }.should     raise_exception 
        proc { @proxy.param? :param_name, "param value" }.should_not raise_exception 
      end

      it "should set the parameter" do
        @proxy.param? :param_name, "param value"
        @proxy.send(:value, :params)[:param_name].should == "param value"
      end
    end

    describe "#first" do
      before do
        @proxy = Client.find
      end

      it "should call the execute method, then call #first on the result" do
        @proxy.should_receive(:execute).and_return ['hi', 'there']
        @proxy.first.should == 'hi'
      end
    end

    describe "#last" do
      before do
        @proxy = Client.find
      end

      it "should call the execute method, then call #last on the result" do
        @proxy.should_receive(:execute).and_return ['hi', 'there']
        @proxy.last.should == 'there'
      end
    end

    
    describe "#each" do
      before do
        Dupe.stub 10, :clients
        @proxy = Client.find
      end

      it "should call #execute" do
        @proxy.should_receive(:execute).and_return []
        @proxy.each {}
      end
    end

    describe "#format" do
      before do
        @proxy = Client.find
        @client = @proxy.send(:value, :client)
      end

      it "should not change client.format" do
        old_fmt = @client.format.extension
        @proxy.execute
        @proxy.send(:value, :format).should be_nil
        @client.format.extension.should == old_fmt
      end

      it "should set format" do
        old_fmt = @client.format.extension
        Client.should_receive(:find_without_chaingang).and_return("world".to_json)
        
        @proxy.from("/hello").format(:json).execute
        @proxy.send(:value, :format).should == :json
        @client.format.extension.should == old_fmt
      end
    end
  end
end
