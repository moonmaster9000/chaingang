module ChainGang
  def self.included(base)
    base.extend ChainGang::ClassMethods
    class << base
      alias_method_chain :find, :chaingang
    end
  end

  module ClassMethods
    def find_with_chaingang
      Proxy.new self
    end
  end
end
