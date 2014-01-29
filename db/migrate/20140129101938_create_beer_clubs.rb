class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|

      t.timestamps
    end
  end
end
