class Events::NewLinkComponent < ViewComponent::Base
  def initialize(time_range:)
    @time_range = time_range
  end

  def new_path
    Events::Paths.new(time_range: time_range).new_path
  end

  private

  attr_reader :time_range
end
