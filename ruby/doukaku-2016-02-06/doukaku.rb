require 'bundler'
Bundler.require

def solve(input)
  'a'
end

def test(input, expect)
  actual = solve(input)

  if actual == expect
    puts "OK: #{input}"
  else
    raise "NG: #{input} : expect #{expect} but got #{actual}"
  end
end

DATA.each_line do |line|
  eval line.match(%r{.*(test.*)}).captures.first
end

__END__
/*0*/ test( "4:(55,44,48)(40,4)(52)(26,29)(23,3)(20,31,21)(5,47)(43)(9,17)(1,8)(32)(25)", "(32,31)" );
