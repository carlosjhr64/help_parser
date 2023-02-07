module HelpParser
  def self.parsea(argv)
    hsh = ArgvHash.new
    n = 0
    argv.each do |a|
      if a[0]=='-'
        break if a.size==1 # '-' quits argv processing
        if a[1]=='-'
          break if a.size==2 # '--' also quits argv processing
          s = a[2..]
          if s.include?('=')
            k,v = s.split('=',2)
            hsh[k] = v
          else
            hsh[s] = true
          end
        else
          a.chars[1..].each do |c|
            hsh[c] = true
          end
        end
      else
        hsh[n] = a
        n += 1
      end
    end
    hsh
  end
end
