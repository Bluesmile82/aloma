class Booking < ActiveRecord::Base

  belongs_to :user, inverse_of: :bookings
  belongs_to :flat, inverse_of: :bookings

  validate :available?

validate :booking_not_in_the_past, :end_date_after_start_date

  def booking_not_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
    if end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def end_date_after_start_date
    if start_date > end_date
      errors.add(:end_date, "must be after the start date")
    end
  end


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

end
