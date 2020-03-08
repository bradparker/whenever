class Day
  attr_reader :year, :month, :value

  def initialize(year, month, value, event_range = nil)
    @year = Year.new(year)
    @month = Month.new(year, month)
    @value = value
    @event_range = event_range
  end

  def week
    Week.new(starts_at.year, starts_at.cweek)
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
