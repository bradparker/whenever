class Events::EditLinkComponent < ViewComponent::Base
  def initialize(event:, time_range:)
    @event = event
    @time_range = time_range
  end

  def edit_path
    Events::Paths.new(
      event: event,
      time_range: time_range.name,
    ).edit_path
  end

  private

  attr_reader :event, :time_range
end
