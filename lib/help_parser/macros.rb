module HelpParser
  def self.float(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ? v.map(&:to_f) : v.to_f)
        end
      end
    end
  end

  def self.integer(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ? v.map(&:to_i) : v.to_i)
        end
      end
    end
  end
end
