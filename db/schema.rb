# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161030220545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "language_phonemes", force: :cascade do |t|
    t.integer "language_id", null: false
    t.integer "phoneme_id",  null: false
  end

  add_index "language_phonemes", ["language_id", "phoneme_id"], name: "index_language_phonemes_on_language_id_and_phoneme_id", unique: true, using: :btree

  create_table "languages", force: :cascade do |t|
    t.string  "inventory_id",          null: false
    t.string  "source",                null: false
    t.string  "language_code",         null: false
    t.string  "language_name",         null: false
    t.integer "trump",                 null: false
    t.string  "canonical_name"
    t.string  "latitude"
    t.string  "longitude"
    t.string  "language_family_root"
    t.string  "language_family_genus"
    t.string  "country"
    t.string  "area"
    t.integer "population"
  end

  create_table "phonemes", force: :cascade do |t|
    t.string "phoneme",                null: false
    t.string "klass",                  null: false
    t.string "combined_klass",         null: false
    t.string "num_of_combined_glyphs", null: false
  end

  add_index "phonemes", ["phoneme"], name: "index_phonemes_on_phoneme", unique: true, using: :btree

  create_table "segments", force: :cascade do |t|
    t.string "segment"
    t.string "tone"
    t.string "stress"
    t.string "syllabic"
    t.string "short"
    t.string "long"
    t.string "consonantal"
    t.string "sonorant"
    t.string "continuant"
    t.string "delayed_release"
    t.string "approximant"
    t.string "tap"
    t.string "trill"
    t.string "nasal"
    t.string "lateral"
    t.string "labial"
    t.string "round"
    t.string "labiodental"
    t.string "coronal"
    t.string "anterior"
    t.string "distributed"
    t.string "strident"
    t.string "dorsal"
    t.string "high"
    t.string "low"
    t.string "front"
    t.string "back"
    t.string "tense"
    t.string "retracted_tongue_root"
    t.string "advanced_tongue_root"
    t.string "periodic_glottal_source"
    t.string "epilaryngeal_source"
    t.string "spread_glottis"
    t.string "constricted_glottis"
    t.string "fortis"
    t.string "ejective"
    t.string "implosive"
    t.string "click"
  end

  add_foreign_key "language_phonemes", "languages"
  add_foreign_key "language_phonemes", "phonemes"
end
