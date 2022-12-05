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
      @hash['#{name}']&.to_f or raise
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
      @hash['#{name}']&.to_f
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
      @hash['#{name}'].map{_1.to_f}
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
      @hash['#{name}']&.map{_1.to_f}
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
      @hash['#{name}']&.to_i or raise
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
      @hash['#{name}']&.to_i
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
      @hash['#{name}'].map{_1.to_i}
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
      @hash['#{name}']&.map{_1.to_i}
    rescue
      raise UsageError, MSG[NOT_INTEGERS,'#{name}']
    end
  end
      CODE
      eval code
    end
  end
end
