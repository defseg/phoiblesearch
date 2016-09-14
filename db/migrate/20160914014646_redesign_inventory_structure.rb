class RedesignInventoryStructure < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do 
        drop_table :inventories
      end

      dir.down do
        create_table :inventories do |t|
          t.integer :inventory_id, null: false
          t.string :source, null: false
          t.string :language_code, null: false
          t.string :language_name, null: false
          t.integer :trump, null: false 
          t.integer :glyph_id, null: false
          t.string :phoneme, null: false
          t.string :klass, null: false
          t.string :combined_klass, null: false
          t.integer :num_of_combined_glyphs, null: false
        end
        add_index :inventories, :phoneme
        add_index :inventories, :language_name
      end
    end

    create_table :languages do |t|
      t.string :inventory_id, null: false 
      t.string :source, null: false
      t.string :language_code, null: false
      t.string :language_name, null: false
      t.integer :trump, null: false
    end
    
    create_table :phonemes do |t|
      t.string :phoneme, null: false
      t.string :klass, null: false
      t.string :combined_klass, null: false
      t.string :num_of_combined_glyphs, null: false
    end
    add_index :phonemes, :phoneme, unique: true

    create_table :language_phonemes do |t|
      t.integer :language_id, null: false
      t.integer :phoneme_id, null: false
    end
    add_foreign_key :language_phonemes, :languages
    add_foreign_key :language_phonemes, :phonemes

    add_index :language_phonemes, [:language_id, :phoneme_id], unique: true
  end
end
