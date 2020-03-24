class Events::Paths
  include Rails.application.routes.url_helpers

  def initialize(
    event:,
    time_range: :day
  )
    @event = event
    @time_range = time_range
  end

  def form_path
    if event.persisted?
      path
    else
      time_range_events_path(time_range)
    end
  end

  def new_path
    new_time_range_event_path(
      time_range,
      event: {
        starts_at: event.starts_at
      }
    )
  end

  def path
    time_range_event_path(time_range, event)
  end

  def edit_path
    edit_time_range_event_path(time_range, event)
  end

  private

  attr_reader :event, :time_range
end
