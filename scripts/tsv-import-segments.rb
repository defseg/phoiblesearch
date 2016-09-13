require "./scripts/tsv.rb"

tsv = Tsv.new("./scripts/phoible-segments-features.tsv")
tsv.parse do |row|
  segment_hash = {}  
  tsv.headers.each do |header| 
    sheader = header.underscore
    sheader = "ejective" if header == "raisedLarynxEjective"
    sheader = "implosive" if header == "loweredLarynxImplosive"
    row_header = row[header] ? row[header].chomp : nil
    segment_hash[sheader] = row_header unless row_header == "0" # null
  end
  segment = Segment.new(segment_hash)
  p segment
  segment.save!
end
