class AddCanonicalNameToLanguages < ActiveRecord::Migration
  def change
  	add_column :languages, :canonical_name, :string
  end
end
