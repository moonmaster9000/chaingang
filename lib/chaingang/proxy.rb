module ChainGang
  class Proxy
    attr_accessor :find_scope

    def initialize(client, id=nil)
      @client = client
      @params = {}
      @find_scope = id || :all
    end

    def from(f); @from = f; self; end

    def first;  self.execute.first; end
    def last;   self.execute.last;  end

    def and;    self; end
    def where;  self; end

    def param(name, value)
      @params[name] = value
      self
    end

    def method_missing(method_name, *args, &block)
      if args.length == 1 && ends_in_exclamation(method_name)
        @params[unexclaim method_name] = args.first
        self
      else
        self.execute.send method_name, *args, &block
      end
    end

    def each
      self.execute.each do |result|
        yield result
      end
    end

    def [](arg)
      self.execute[arg]
    end

    def execute
      options = {}
      options[:from] = @from if @from
      options[:params] = @params
      @client.find_without_chaingang(@find_scope, options)
    end
  
    private 
    def value(attr)
      eval "@#{attr}"
    end

    def ends_in_exclamation(string)
      string.to_s[-1..-1] == "!"
    end

    def unexclaim(string)
      string.to_s[0..-2].to_sym
    end
  end
end
