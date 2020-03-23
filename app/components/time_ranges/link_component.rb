class TimeRanges::LinkComponent < ViewComponent::Base
  def initialize(time_range:)
    @time_range = time_range
  end

  def path
    TimeRanges::Paths.new(time_range).path
  end

  private

  attr_reader :time_range
end
