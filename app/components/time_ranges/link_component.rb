class TimeRanges::LinkComponent < ViewComponent::Base
  attr_reader :classname

  def initialize(props)
    @time_range = props.fetch(:time_range)
    @classname = props.fetch(:class, "")
  end

  def path
    TimeRanges::Paths.new(time_range).path
  end

  private

  attr_reader :time_range
end
