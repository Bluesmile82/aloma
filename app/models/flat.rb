class Flat < ActiveRecord::Base

  validates :name, :description, :price, :city, :country, :zipcode, presence: true
  validates :price, numericality: true
  belongs_to :user
  has_many :bookings

  has_many :pictures, inverse_of: :flat, dependent: :destroy
  has_many :availabilities

  accepts_nested_attributes_for :pictures
end
