class Flat < ActiveRecord::Base

  belongs_to :user
  has_many :bookings

  has_many :pictures


  has_many :availabilities

end
