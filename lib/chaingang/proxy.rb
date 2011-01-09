module ChainGang
  class Proxy
    def initialize(client)
      @client = client
      @params = {}
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

    private 
    def value(attr)
      eval "@#{attr}"
    end
  end
end
