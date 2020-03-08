class Year
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def starts_at
    Date.new(value.to_i)
  end

  def months
    @months ||= (1..12).map do |month|
      Month.new(value, month, event_range)
    end
  end

  def to_param
    value.to_s.rjust(4, '0')
  end

  private

  def event_range
    @event_range ||= EventRange.new(starts_at.all_year)
  end
end
