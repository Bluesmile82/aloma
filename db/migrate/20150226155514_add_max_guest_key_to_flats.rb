class AddMaxGuestKeyToFlats < ActiveRecord::Migration
  def change
    add_column :flats, :max_guest, :integer
  end
end
