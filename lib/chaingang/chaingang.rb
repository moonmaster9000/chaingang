module ChainGang
  def self.included(base)
    base.extend ChainGang::ClassMethods
    class << base
      alias_method_chain :find, :chaingang
    end
  end

  module ClassMethods
    def find_with_chaingang(id=nil)
      if id
        find_without_chaingang id 
      else
        Proxy.new self
      end
    end
  end
end
