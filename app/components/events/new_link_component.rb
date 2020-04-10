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
    @starts_at ||= Time.use_zone(time_range.time_zone) do
      now = Time.zone.now
      Time.zone.local(
        time_range.starts_at.year,
        time_range.starts_at.month,
        time_range.starts_at.day,
        now.hour
      )
    end
  end
end
