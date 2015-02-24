class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image_url
      t.references :flat, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :flats
  end
end
