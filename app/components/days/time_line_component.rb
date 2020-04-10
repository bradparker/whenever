class Days::TimeLineComponent < ViewComponent::Base
  attr_reader :day, :time_range

  def initialize(day:, time_range: day)
    @day = day
    @time_range = time_range
  end

  def grid_row_start(event)
    ((starts_at(event) - starts_at(event).beginning_of_day) / 60).to_i + 1
  end

  def grid_row_span(event)
    ((ends_at(event) - starts_at(event)) / 60).to_i
  end

  def starts_at(event)
    event.starts_at.in_time_zone(time_range.time_zone)
  end

  def ends_at(event)
    event.ends_at.in_time_zone(time_range.time_zone)
  end
end
