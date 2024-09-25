module HelpParser
  def self.integer(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ? v.map(&:to_i) : v.to_i)
        end
      end
    end
  end

  def self.float(*names)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ? v.map(&:to_f) : v.to_f)
        end
      end
    end
  end

  def self.map(*names, map:)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ?
                                    v.map(&map) :
                                    v.method(map).call)
        end
      end
    end
  end

  def self.csv(*names, csv: ',', map: :strip)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ?
                                    v.map{_1.split(csv).map(&map)} :
                                    v.split(csv).map(&map))
        end
      end
    end
  end
end
