class TimeRanges::HeaderComponent < ViewComponent::Base
  attr_reader :time_range

  def initialize(time_range:)
    @time_range = time_range
  end

  def display_name
    case time_range
    when Day
      time_range.starts_at.strftime("%A %-d %B %Y")
    when Week
      "Week #{time_range.value} #{time_range.year.value}"
    when Month
      time_range.starts_at.strftime("%B %Y")
    when Year
      time_range.value.to_s
    end
  end

  def containing_ranges
    case time_range
    when Day
      [time_range.month, time_range.week]
    when Week
      [time_range.year]
    when Month
      [time_range.year]
    when Year
      []
    end
  end

  def containing_range_name(range)
    case range
    when Week
      base = "Week #{range.value}"
      return base + " #{range.year.value}" if range.year != time_range.year
      base
    when Month
      range.starts_at.strftime("%B")
    when Year
      range.value.to_s
    end
  end
end
