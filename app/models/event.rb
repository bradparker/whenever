class Event < ApplicationRecord
  belongs_to :user

  validate :ends_at_must_be_after_starts_at

  def ends_at_must_be_after_starts_at
    if ends_at < starts_at
      errors.add(:ends_at, "must be after start")
    end
  end

  delegate :week, :month, :year, to: :day

  def day
    user.day_from_date(starts_at.in_time_zone(user.time_zone).to_date)
  end

  def time_range(name)
    if %i[week month year day].exclude? name
      raise ArgumentError, "Unknown time range name #{name}"
    end

    public_send(name)
  end
end
