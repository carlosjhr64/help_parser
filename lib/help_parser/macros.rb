module HelpParser
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
  def self.integer(*names)  = HelpParser.map(*names, map: :to_i)
  def self.float(*names)    = HelpParser.map(*names, map: :to_f)
  def self.rational(*names) = HelpParser.map(*names, map: :to_r)

  def self.split(*names, sep: ',', map: :strip)
    names.each do |name|
      Options.instance_eval do
        define_method(name) do
          v = @hash[name.to_s] and (v.is_a?(Array) ?
                                    v.map{_1.split(sep).map(&map)} :
                                    v.split(sep).map(&map))
        end
      end
    end
  end
  def self.csv(*names) = HelpParser.split(*names)
end
