module ChainGang
  class Proxy
    def initialize(client)
      @client = client
    end

    def one;    @find_scope = :one;   self; end
    def all;    @find_scope = :all;   self; end
    def first;  @find_scope = :first; self; end
    def last;   @find_scope = :last;  self; end
    
    def single(id)
      @find_scope = id
      self
    end

    def __find_scope; @find_scope;  end
    def __client;     @client;      end
  end
end
