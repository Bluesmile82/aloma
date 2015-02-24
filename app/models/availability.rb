class Availability < ActiveRecord::Base
  belongs_to :flat
  validate :availability_not_in_the_past, :end_date_after_start_date
  after_validation :update_availabilities

  def availability_not_in_the_past
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

  # def no_overlapping
  #   flat.availabilities.each do |availability|
  #     if start_date > availavility.start_date &&  start_date < availavility.end_date
  #      errors.add(:end_date, "")
  #     end
  #   end
  # end

  def update_availabilities

    flat.availabilities.each do |availability|

      if availability.start_date > start_date && availability.end_date < end_date
        availability.destroy
      elsif
        availability.start_date < start_date && availability.end_date > start_date
        params[:start_date] = availability.start_date
        availability.destroy
      end


    end
  end
end
