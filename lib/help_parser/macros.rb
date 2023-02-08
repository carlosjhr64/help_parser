module HelpParser
  def self.string(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          s = @hash[name.to_s]
          raise UsageError, MSG[NOT_STRING,name] unless s.is_a?(String)
          s
        end
      end
    end
  end

  def self.string?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          s = @hash[name.to_s]
          raise UsageError,MSG[NOT_STRING,name] unless s.nil? || s.is_a?(String)
          s
        end
      end
    end
  end

  def self.strings(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          a = @hash[name.to_s]
          raise UsageError, MSG[NOT_STRINGS,name] unless a.is_a?(Array)
          a
        end
      end
    end
  end

  def self.strings?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          a = @hash[name.to_s]
          raise UsageError,MSG[NOT_STRINGS,name] unless a.nil? || a.is_a?(Array)
          a
        end
      end
    end
  end

  def self.float(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          @hash[name.to_s]&.to_f or raise
        rescue
          raise UsageError, MSG[NOT_FLOAT,name]
        end
      end
    end
  end

  def self.float?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          @hash[name.to_s]&.to_f
        rescue
          raise UsageError, MSG[NOT_FLOAT,name]
        end
      end
    end
  end

  def self.floats(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          @hash[name.to_s].map(&:to_f)
        rescue
          raise UsageError, MSG[NOT_FLOATS,name]
        end
      end
    end
  end

  def self.floats?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          @hash[name.to_s]&.map(&:to_f)
        rescue
          raise UsageError, MSG[NOT_FLOATS,name]
        end
      end
    end
  end

  def self.int(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          @hash[name.to_s]&.to_i or raise
        rescue
          raise UsageError, MSG[NOT_INTEGER,name]
        end
      end
    end
  end

  def self.int?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          @hash[name.to_s]&.to_i
        rescue
          raise UsageError, MSG[NOT_INTEGER,name]
        end
      end
    end
  end

  def self.ints(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          @hash[name.to_s].map(&:to_i)
        rescue
          raise UsageError, MSG[NOT_INTEGERS,name]
        end
      end
    end
  end

  def self.ints?(*names)
    names.each do |name|
      Options.instance_eval do
        define_method("#{name}?") do
          @hash[name.to_s]&.map(&:to_i)
        rescue
          raise UsageError, MSG[NOT_INTEGERS,name]
        end
      end
    end
  end
end
