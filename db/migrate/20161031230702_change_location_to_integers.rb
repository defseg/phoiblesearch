class ChangeLocationToIntegers < ActiveRecord::Migration
  def change
  	remove_column :languages, :latitude, :string
  	remove_column :languages, :longitude, :string
  	add_column :languages, :latitude, :float
  	add_column :languages, :longitude, :float
  end
end
