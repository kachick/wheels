require 'find'

def each_filepath(root, *ignore_rxps)
  return to_enum(__callee__, root, *ignore_rxps) unless block_given?
  
  Find.find root do |path|
    if FileTest.directory? path
      if ignore_rxps.any?{|rxp|rxp =~ path}
        Find.prune
      end
    else
      yield path
    end
  end
end

if $PROGRAM_NAME == __FILE__
  root = ARGV.shift
  ignore_rxps = ARGV.map{|s|Regexp.new s}
  
  each_filepath root, *ignore_rxps do |path|
    puts path
  end
end
