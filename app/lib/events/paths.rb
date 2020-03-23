class Events::Paths
  include Rails.application.routes.url_helpers

  def initialize(
    id: nil,
    time_range: TimeRange.from_date(date: Date.today)
  )
    @id = id
    @time_range = time_range
  end

  def new_path
    new_event_path(
      time_range: time_range_name,
      event: {
        starts_at: time_range.starts_at.to_time(:utc)
      }
    )
  end

  def path
    event_path(id, time_range: time_range_name)
  end

  def edit_path
    edit_event_path(id, time_range: time_range_name)
  end

  private

  attr_reader :id, :time_range

  def time_range_name
    TimeRange.name(time_range)
  end
end
