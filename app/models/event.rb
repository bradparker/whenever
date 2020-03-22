class Event < ApplicationRecord
  validate :ends_at_must_be_after_starts_at

  delegate :week, :month, :year, to: :day

  def day
    Day.from_date(starts_at.to_date)
  end

  def ends_at_must_be_after_starts_at
    if ends_at < starts_at
      errors.add(:ends_at, "must be after start")
    end
  end
end
