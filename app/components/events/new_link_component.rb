class Events::NewLinkComponent < ViewComponent::Base
  attr_reader :classname

  def initialize(props)
    @time_range = props.fetch(:time_range)
    @classname = props.fetch(:class, "")
  end

  def new_path
    Events::Paths.new(
      event: Event.new(starts_at: starts_at),
      time_range: time_range.name,
    ).new_path
  end

  private

  attr_reader :time_range

  def starts_at
    now = Time.now.utc
    time_range.starts_at.to_time(:utc) + now.hour.hours
  end
end
