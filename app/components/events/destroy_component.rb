class Events::DestroyComponent < ViewComponent::Base
  def initialize(event:, time_range:)
    @event = event
    @time_range = time_range
  end

  def path
    Events::Paths.new(
      event: event,
      time_range: TimeRange.name(time_range),
    ).path
  end

  private

  attr_reader :event, :time_range
end
