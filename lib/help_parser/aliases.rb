module HelpParser
  class NoDupHash < Hash
    def []=(k,v)
      raise HelpError, MSG[DUP_KEY,k]  if self.has_key?(k)
      super
    end
  end

  class ArgvHash < Hash
    def []=(k,v)
      raise UsageError, MSG[DUP_KEY,k] if self.has_key?(k)
      super
    end
  end
end
