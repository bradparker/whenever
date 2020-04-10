class Events::FormComponent < ViewComponent::Base
  attr_reader :event

  def initialize(event:, time_range:)
    @event = event
    @time_range = time_range
  end

  def path
    Events::Paths.new(
      event: event,
      time_range: time_range.name
    ).form_path
  end

  def action
    if event.persisted?
      :patch
    else
      :post
    end
  end

  def starts_at
    event.starts_at.in_time_zone(time_range.time_zone)
  end

  def ends_at
    event.ends_at.in_time_zone(time_range.time_zone)
  end

  private

  attr_reader :time_range
end
