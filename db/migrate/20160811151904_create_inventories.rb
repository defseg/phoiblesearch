class CreateInventories < ActiveRecord::Migration
  def change
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
