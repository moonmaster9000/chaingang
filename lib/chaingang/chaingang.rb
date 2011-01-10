module ChainGang
  def self.included(base)
    base.extend ChainGang::ClassMethods
    class << base
      alias_method_chain :find, :chaingang
    end
  end

  module ClassMethods
    # the #find method is aliased to this.
    # If you call #find with no arguments, it's assumed
    # you're doing a find(:all).
    #     Article.find # defaults to :all
    #     Article.find(:first)
    #     Article.find(:last)
    #     Article.find(:one)
    #     Article.find('some-id')
    def find_with_chaingang(find_scope = :all)
      Proxy.new(self, find_scope)
    end
  end
end
