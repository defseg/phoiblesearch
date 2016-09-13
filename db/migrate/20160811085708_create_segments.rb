class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.string :segment, unique: true
      t.string :tone
      t.string :stress
      t.string :syllabic
      t.string :short
      t.string :long
      t.string :consonantal
      t.string :sonorant
      t.string :continuant
      t.string :delayed_release
      t.string :approximant
      t.string :tap
      t.string :trill
      t.string :nasal
      t.string :lateral
      t.string :labial
      t.string :round
      t.string :labiodental
      t.string :coronal
      t.string :anterior
      t.string :distributed
      t.string :strident
      t.string :dorsal
      t.string :high
      t.string :low
      t.string :front
      t.string :back
      t.string :tense
      t.string :retracted_tongue_root
      t.string :advanced_tongue_root
      t.string :periodic_glottal_source
      t.string :epilaryngeal_source
      t.string :spread_glottis
      t.string :constricted_glottis
      t.string :fortis
      t.string :ejective
      t.string :implosive
      t.string :click
    end
  end
end
