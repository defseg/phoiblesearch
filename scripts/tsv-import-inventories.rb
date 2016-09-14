require "./scripts/tsv.rb"

class Hash
  def process(props)
    # A method to take a row from the TSV and return a hash to create an AR object:
    # select the properties in the 'props' array, then edit the resulting hash
    # to replace "class", which can't appear in AR columns, with "klass", and
    # remove whitespace from the value. Hash#map returns an array, so .to_h.
    self.select { |k, v| props.include?(k) }.map { |k, v| [k.underscore.gsub("class", "klass"), v.chomp] }.to_h
  end
end

tsv = Tsv.new("./scripts/phoible-phonemes.tsv")
tsv.parse do |row|
  # These properties have to do with the language:
  # InventoryID         - the ID of the source/language pair in PHOIBLE's database
  # Source              - the database PHOIBLE used as a source for the inventory
  # LanguageCode        - the ISO 639-(2? 3?) code for the language
  # LanguageName        - the name of the language
  # Trump               - holds the nth instance of the language in the DB (in case of multiple sources)
  # These properties have to do with the phoneme:
  # PhonemeID           - the ID of the row 
  # GlyphID             - the ID of the phoneme's IPA representation in PHOIBLE's DB
  # Phoneme             - the IPA representation of the phoneme
  # Class               - consonant, vowel, or tone
  # CombinedClass       - consonant, diacritic, vowel, etc.
  # NumOfCombinedGlyphs - number of codepoints comprising the IPA representation of the character

  # Import InventoryID because sometimes the same source lists the same language twice.
  # (PH, Barbareño) 
  language_properties = ["InventoryID", "Source", "LanguageCode", "LanguageName", "Trump"]
  phoneme_properties  = ["Phoneme", "Class", "CombinedClass", "NumOfCombinedGlyphs"] 
  
  # Check if the language-source combination (hereafter "language") already exists.
  unless (language = Language.find_by(inventory_id: row["InventoryID"]))
    language = Language.new(row.process(language_properties))
    p language
    language.save!
  end
  # Do the same for the phoneme.
  unless (phoneme = Phoneme.find_by(phoneme: row["Phoneme"]))
    phoneme = Phoneme.new(row.process(phoneme_properties))
    p phoneme
    phoneme.save!
  end
  language_phoneme = LanguagePhoneme.new({language: language, phoneme: phoneme})
  p language_phoneme 
  language_phoneme.save!
end
