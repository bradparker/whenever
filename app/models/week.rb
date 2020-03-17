# frozen_string_literal: true

class Week
  attr_reader :year, :value

  def initialize(year, value, event_range = nil)
    @year = Year.new(year)
    @value = value
    @event_range = event_range
  end

  def starts_at
    @starts_at ||= Date.commercial(year.value, value)
  end

  def prev
    prev_starts_at = starts_at - 1.week
    Week.new(prev_starts_at.cwyear, prev_starts_at.cweek)
  end

  def next
    next_starts_at = starts_at + 1.week
    Week.new(next_starts_at.cwyear, next_starts_at.cweek)
  end

  def ends_at
    starts_at.end_of_week
  end

  def month
    Month.new(starts_at.year, starts_at.month)
  end

  def days
    @days ||= starts_at.all_week.map do |date|
      Day.new(date.year, date.month, date.day, event_range)
    end
  end

  def to_param
    value.to_s
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_week)
  end
end
