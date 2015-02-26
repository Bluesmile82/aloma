class Booking < ActiveRecord::Base
  belongs_to :user, inverse_of: :bookings
  belongs_to :flat, inverse_of: :bookings
end
