class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true
      t.references :flat, index: true
      t.date :start_date
      t.date :end_date
      t.text :review_content
      t.integer :review_rating

      t.timestamps null: false
    end
    add_foreign_key :bookings, :users
    add_foreign_key :bookings, :flats
  end
end
