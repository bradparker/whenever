class TimeRanges::NavigationComponent < ViewComponent::Base
  attr_reader :time_range

  def initialize(time_range:)
    @time_range = time_range
  end

  def current_range_display_name
    case time_range
    when Day
      "Today"
    else
      "This #{time_range.name}"
    end
  end

  def current_range_path
    time_range_path(time_range.name)
  end

  def next_range_display_name
    range_display_name(time_range.next)
  end

  def next_range_path
    TimeRanges::Paths.new(time_range.next).path
  end

  def prev_range_display_name
    range_display_name(time_range.prev)
  end

  def prev_range_path
    TimeRanges::Paths.new(time_range.prev).path
  end

  private

  def range_display_name(range)
    case range
    when Day
      range.starts_at.strftime("%a, %d %b %Y")
    when Week
      "Week #{range.value}, #{range.year.value}"
    when Month
      range.starts_at.strftime("%B, %Y")
    when Year
      range.value.to_s
    end
  end
end
