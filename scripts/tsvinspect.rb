# A script to inspect a TSV file.
# The name of the file to inspect should be passed in as an argument.

require './tsv.rb'

tsv = Tsv.new(ARGV[0])
headers_hash = Hash.new
tsv.parse do |row|
  tsv.headers.each do |header|
    headers_hash[header] ||= Hash.new(0)
    headers_hash[header][row[header]] += 1
  end
end
headers_hash.keys.each do |header|
  puts "Header: #{header}"
    if headers_hash[header].keys.length > 50
      puts "  Too many values to list; an example is #{headers_hash[header].keys.sample}"
      next
    end
  headers_hash[header].keys.sort.each do |value|
    puts "  #{value.chomp}: #{headers_hash[header][value]}"
  end
end
