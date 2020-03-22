class Events::EditLinkComponent < ViewComponent::Base
  def initialize(event:, time_range:)
    @event = event
    @time_range = time_range
  end

  def path
    urls.edit_path
  end

  private

  attr_reader :event, :time_range

  def urls
    @urls ||= Events::Urls.new(
      id: event.id,
      time_range: time_range,
    )
  end
end
