# TODO: update this to add canonical names
require "./scripts/tsv.rb"

class Hash
  def process(props)
    # A method to take a row from the TSV and return a hash for AR.
    self.select { |k, v| props.include?(k) }.map { |k, v| [k.underscore, ((v.class == String) ? v.chomp : v)] }.to_h
  end
end

tsv = Tsv.new("./scripts/phoible-aggregated.tsv")
tsv.parse do |row|
  # InventoryID         - the ID of the source/language pair in PHOIBLE's database
  # LanguageFamilyRoot
  # LanguageFamilyGenus
  # Country
  # Area
  # Population
  # Latitude
  # Longitude

  props = ["InventoryID", "LanguageFamilyRoot", "LanguageFamilyGenus", "Country", "Area", "Population", "Latitude", "Longitude"]

  language = Language.find(row["InventoryID"])

  # manually correct malformed/exceptional data
  row["Latitude"]  = nil if row["Latitude"]  == "NULL"
  row["Longitude"] = nil if row["Longitude"] == "NULL"
  row["Population"] = row["Population"].gsub(",","").to_i

  language.update_attributes(row.process(props))
  p language
end
