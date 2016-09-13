# Print a list of all segments that collide under PHOIBLE's featural system --
# that is, those segments that don't have a unique featural decomposition.

require './tsv.rb'

tsv = Tsv.new(ARGV[0])
collisions = Hash.new 

tsv.parse do |row|
  seg = row.delete("segment")
  collisions[row] ||= []
  collisions[row].push(seg)
end

collisions.delete_if { |k, v| v.length < 2 }
collisions.values.each do |v|
  v.each do |f|
    print "#{f} "
  end
  puts ""
end
