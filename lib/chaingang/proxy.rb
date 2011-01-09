module ChainGang
  class Proxy
    def initialize(client)
      @client = client
      @params = {}
      @find_scope = :all
    end

    def from(f); @from = f; self; end

    def one;    @find_scope = :one;   self; end
    def all;    @find_scope = :all;   self; end
    def first;  @find_scope = :first; self; end
    def last;   @find_scope = :last;  self; end
    
    def single(id)
      @find_scope = id
      self
    end

    def and;    self; end
    def where;  self; end

    def method_missing(method_name, *args, &block)
      if args.length == 1
        @params[method_name] = args.first
      else
        super method_name, *args, &block
      end
      self
    end

    def each
      self.execute.each do |result|
        yield result
      end
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
  end
end
