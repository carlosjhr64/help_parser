module HelpParser
  def self.string(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      s = @hash['#{name}']
      raise UsageError, MSG[NOT_STRING,'#{name}'] unless s.is_a?(String)
      return s
    end
  end
      CODE
      eval code
    end
  end

  def self.string?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      s = @hash['#{name}']
      raise UsageError, MSG[NOT_STRING,'#{name}'] unless s.nil? ||
        s.is_a?(String)
      return s
    end
  end
      CODE
      eval code
    end
  end

  def self.strings(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      a = @hash['#{name}']
      raise UsageError, MSG[NOT_STRINGS,'#{name}'] unless a.is_a?(Array)
      return a
    end
  end
      CODE
      eval code
    end
  end

  def self.strings?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      a = @hash['#{name}']
      raise UsageError, MSG[NOT_STRINGS,'#{name}'] unless a.nil? ||
        a.is_a?(Array)
      return a
    end
  end
      CODE
      eval code
    end
  end

  def self.float(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      f = @hash['#{name}']
      raise if f.nil?
      f.to_f
    rescue
      raise UsageError, MSG[NOT_FLOAT,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.float?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      f = @hash['#{name}']
      f = f.to_f if f
      return f
    rescue
      raise UsageError, MSG[NOT_FLOAT,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.floats(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      f = @hash['#{name}']
      raise unless f.is_a?(Array)
      f.map{|_|_.to_f}
    rescue
      raise UsageError, MSG[#{NOT_FLOATS},'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.floats?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      f = @hash['#{name}']
      return nil unless f
      raise unless f.is_a?(Array)
      f.map{|_|_.to_f}
    rescue
      raise UsageError, MSG[NOT_FLOATS,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.int(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      f = @hash['#{name}']
      raise if f.nil?
      f.to_i
    rescue
      raise UsageError, MSG[NOT_INTEGER,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.int?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      f = @hash['#{name}']
      f = f.to_i if f
      return f
    rescue
      raise UsageError, MSG[NOT_INTEGER,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.ints(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}
      f = @hash['#{name}']
      raise unless f.is_a?(Array)
      f.map{|_|_.to_i}
    rescue
      raise UsageError, MSG[NOT_INTEGERS,'#{name}']
    end
  end
      CODE
      eval code
    end
  end

  def self.ints?(*names)
    names.each do |name|
      code = <<-CODE
  class Options
    def #{name}?
      f = @hash['#{name}']
      return nil unless f
      raise unless f.is_a?(Array)
      f.map{|_|_.to_i}
    rescue
      raise UsageError, MSG[NOT_INTEGERS,'#{name}']
    end
  end
      CODE
      eval code
    end
  end
end
