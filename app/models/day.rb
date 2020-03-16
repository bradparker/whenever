class Day
  attr_reader :year, :month, :value

  def initialize(year, month, value, event_range = nil)
    @year = Year.new(year)
    @month = Month.new(year, month)
    @value = value
    @event_range = event_range
  end

  def week
    Week.new(starts_at.cwyear, starts_at.cweek)
  end

  def prev
    prev_starts_at = starts_at - 1.day
    Day.new(prev_starts_at.year, prev_starts_at.month, prev_starts_at.day)
  end

  def next
    next_starts_at = starts_at + 1.day
    Day.new(next_starts_at.year, next_starts_at.month, next_starts_at.day)
  end

  def starts_at
    Date.new(year.value, month.value, value)
  end

  def events
    @events ||= event_range.on(starts_at)
  end

  def event_count
    event_range.count(starts_at)
  end

  def to_param
    value.to_s.rjust(2, '0')
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_day)
  end
end
