class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :start_date
      t.date :end_date
      t.references :flat, index: true

      t.timestamps null: false
    end
    add_foreign_key :availabilities, :flats
  end
end
