class TimeRanges::LinkComponent < ViewComponent::Base
  def initialize(time_range:)
    @time_range = time_range
  end

  def path
    urls.path
  end

  private

  attr_reader :time_range

  def urls
    @urls ||= TimeRanges::Urls.new(time_range)
  end
end
