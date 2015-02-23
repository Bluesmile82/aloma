class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
      t.string :name
      t.string :description
      t.float :price
      t.string :street
      t.string :city
      t.string :country
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
