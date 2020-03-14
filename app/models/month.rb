class Month
  attr_reader :year, :value

  def initialize(year, value, event_range = nil)
    @year = Year.new(year)
    @value = value
    @event_range = event_range
  end

  def starts_at
    @starts_at ||= Date.new(year.value, value)
  end

  def prev
    prev_starts_at = starts_at - 1.month
    Month.new(prev_starts_at.year, prev_starts_at.month)
  end

  def next
    next_starts_at = starts_at + 1.month
    Month.new(next_starts_at.year, next_starts_at.month)
  end

  def weeks
    @weeks ||= (starts_at.cweek .. starts_at.end_of_month.cweek).map do |week|
      Week.new(year.value, week, event_range)
    end
  end

  def to_param
    value.to_s.rjust(2, '0')
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_month)
  end
end
