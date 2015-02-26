class Booking < ActiveRecord::Base

  belongs_to :user, inverse_of: :bookings
  belongs_to :flat, inverse_of: :bookings

  validate :available?

  def available?
    result = false
    # byebug
    @flat = Flat.find(flat_id)
    @flat.availabilities.each do |a|
      if a.start_date <= start_date && a.end_date > start_date && a.end_date >= end_date
        result = true
      end
    end
    if result == false
      errors.add(:end_date, "Flat not available, choose another date")
    end
    result
  end
>>>>>>> c07b3000128c625011778ffe9c39b9c371d6ceab
end
