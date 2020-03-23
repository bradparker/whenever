class Event < ApplicationRecord
  validate :ends_at_must_be_after_starts_at

  def ends_at_must_be_after_starts_at
    if ends_at < starts_at
      errors.add(:ends_at, "must be after start")
    end
  end

  delegate :week, :month, :year, to: :day

  def day
    Day.from_date(starts_at.to_date)
  end

  def time_range(name)
    if %i[week month year day].exclude? name
      raise ArgumentError, "Unknown time range name #{name}"
    end

    public_send(name)
  end
end
