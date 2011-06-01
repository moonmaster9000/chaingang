module ChainGang
  class Proxy
    attr_accessor :find_scope

    def initialize(client, id=nil)
      @client = client
      @params = {}
      @find_scope = id || :all
    end

    # Specify a custom url path to retrieve send 
    # the service call to.
    #     Article.find(:all).from :published
    def from(f); @from = f; self; end

    # Simply improves readability. Does nothing but return self.
    #     Article.find.where.author?("moonmaster9000").and.published?(true)
    def and;    self; end

    # Simply improves readability. Does nothing but return self.
    #     Article.find.where.author?("moonmaster9000").and.published?(true)
    def where;  self; end

    # Suppose you have a parameter name that collides with an existing method.
    # Simply set it with this param? method:
    #     Article.find(:all).param?(:from, "New York Times")
    def param?(name, value)
      @params[name] = value
      self
    end

    # allow active resource to execute request with custom xml/json format from default.
    #   Article.find(:all).by?("moonmaster9000").format(:json)
    def format(fmt)
      @format = fmt.to_sym
      self
    end

    # Set the query string parameters on your request by calling them as methods
    # with a question mark at the end. 
    #     Article.find(:all).where.author?("moonmaster9000") #/articles.xml?author=moonmaster9000
    def method_missing(method_name, *args, &block)
      if args.length == 1 && question?(method_name)
        @params[unquestion method_name] = args.first
        self
      else
        self.execute.send method_name, *args, &block
      end
    end

    # Make the service call immediately. 
    #     Article.find(:all).execute
    def execute
      options = {}
      options[:from] = @from if @from
      options[:params] = @params
      @client.find_without_chaingang(@find_scope, options)
    end
    alias_method :execute_without_format, :execute

    # execute the request in specified format, then revert it back after the request.
    def execute_with_format
      fmt = @format
      if fmt && fmt.to_s != @client.format.extension
        old = @client.format.extension
        @client.format = fmt.to_sym
        result = execute_without_format
        @client.format = old.to_sym
        return result
      else
        execute_without_format
      end
    end
    alias_method :execute, :execute_with_format
    
    private 
    # @private
    def value(attr) #:nodoc:
      eval "@#{attr}"
    end
    
    # @private
    def question?(string) #:nodoc:
      string.to_s[-1..-1] == "?"
    end

    # @private
    def unquestion(string) #:nodoc:
      string.to_s[0..-2].to_sym
    end
  end
end
