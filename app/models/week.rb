# frozen_string_literal: true

class Week
  include TimeRange::Naming

  def self.from_date(date)
    new(date.cwyear, date.cweek)
  end

  attr_reader :year, :value, :starts_at

  def initialize(year, value, event_range = nil)
    @year = Year.new(year)
    @value = value
    @starts_at = Date.commercial(year, value)
    @event_range = event_range
  end

  def prev
    Week.from_date(starts_at.prev_week)
  end

  def next
    Week.from_date(starts_at.next_week)
  end

  def month
    Month.from_date(starts_at)
  end

  def days
    @days ||= starts_at.all_week.map do |date|
      Day.from_date(date, event_range)
    end
  end

  def days_by_month
    days.group_by(&:month)
  end

  def eql?(other)
    year == other.year && value == other.value
  end

  def ==(other)
    eql?(other)
  end

  def hash
    year.hash ^ value.hash
  end

  def to_param
    value.to_s
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_week)
  end
end
