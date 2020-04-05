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
      time_range.months
    when Month
      [time_range.year]
    when Year
      []
    end
  end

  def containing_range_name(range)
    case range
    when Week
      if time_range.year != range.year
        "Week #{range.value} #{range.year.value}"
      else
        "Week #{range.value}"
      end
    when Month
      if time_range.year != range.year
        range.starts_at.strftime("%B %Y")
      else
        range.starts_at.strftime("%B")
      end
    when Year
      range.value.to_s
    end
  end
end
