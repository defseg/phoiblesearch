require "./scripts/tsv.rb"

tsv = Tsv.new("./scripts/phoible-phonemes.tsv")
tsv.parse do |row|
  obj_hash = {}  
  tsv.headers.each do |header| 
    next if header == "PhonemeID"
    oheader = header.underscore.gsub("class", "klass") # class is a reserved word
    row_header = row[header].chomp
    obj_hash[oheader] = row_header # we shouldn't have nulls
  end
  obj = Inventory.new(obj_hash)
  p obj
  obj.save!
end
