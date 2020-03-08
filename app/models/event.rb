class Event < ApplicationRecord
  def day
    Day.new(starts_at.year, starts_at.month, starts_at.day)
  end
end
