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
      events_path(time_range: time_range)
    end
  end

  def new_path
    new_event_path(
      time_range: time_range,
      event: {
        starts_at: event.starts_at
      }
    )
  end

  def path
    event_path(event, time_range: time_range)
  end

  def edit_path
    edit_event_path(event, time_range: time_range)
  end

  private

  attr_reader :event, :time_range
end
