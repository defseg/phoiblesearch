class AddGeoDataToLanguages < ActiveRecord::Migration
  def change
  	add_column :languages, :latitude, :string
  	add_column :languages, :longitude, :string
  	add_column :languages, :language_family_root, :string
  	add_column :languages, :language_family_genus, :string
  	add_column :languages, :country, :string
  	add_column :languages, :area, :string
  	add_column :languages, :population, :integer
  end
end
