class TimeRanges::Paths
  include Rails.application.routes.url_helpers

  def initialize(time_range)
    @time_range = time_range
  end

  def path
    case time_range
    when Year
      year_path(time_range)
    when Month
      year_month_path(time_range.year, time_range)
    when Week
      year_week_path(time_range.year, time_range)
    when Day
      year_month_day_path(time_range.year, time_range.month, time_range)
    end
  end

  private

  attr_reader :time_range
end
