class AddAttributesToBeerClub < ActiveRecord::Migration
  def change
	add_column :beer_clubs, :name, :string
	add_column :beer_clubs, :founded, :integer
	add_column :beer_clubs, :city, :string
  end
end
