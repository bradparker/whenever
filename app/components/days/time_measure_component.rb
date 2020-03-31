class Days::TimeMeasureComponent < ViewComponent::Base
  def initialize
  end

  def beginning_of_day
    @beginning_of_day ||= Time.now.utc.beginning_of_day
  end
end
