class Events::NewLinkComponent < ViewComponent::Base
  def initialize(time_range:)
    @time_range = time_range
  end

  def new_path
    Events::Paths.new(
      event: Event.new(starts_at: starts_at),
      time_range: time_range_name
    ).new_path
  end

  private

  attr_reader :time_range

  def time_range_name
    TimeRange.name(time_range)
  end

  def starts_at
    now = Time.now.utc
    time_range.starts_at.to_time(:utc) + now.hour.hours
  end
end
