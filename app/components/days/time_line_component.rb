class Days::TimeLineComponent < ViewComponent::Base
  attr_reader :day

  def initialize(day:)
    @day = day
  end

  def grid_row_start(event)
    ((event.starts_at - event.starts_at.beginning_of_day) / 60).to_i
  end

  def grid_row_span(event)
    ((event.ends_at - event.starts_at) / 60).to_i
  end
end
