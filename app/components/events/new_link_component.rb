class Events::NewLinkComponent < ViewComponent::Base
  attr_reader :time_range

  def initialize(time_range:)
    @time_range = time_range
  end

  def url
    urls.new_path
  end

  private

  def urls
    @urls ||= Events::Urls.new(
      time_range: time_range,
    )
  end
end
