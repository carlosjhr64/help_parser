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

  def self.f2k(f)
    f[1]=='-' ? f[2..((f.index('=')||0)-1)] : f[1]
  end
end
