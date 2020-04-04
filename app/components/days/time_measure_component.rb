class Days::TimeMeasureComponent < ViewComponent::Base
  def initialize(display_numbers: true)
    @display_numbers = display_numbers
  end

  def display_numbers?
    @display_numbers
  end

  def beginning_of_day
    @beginning_of_day ||= Time.now.utc.beginning_of_day
  end
end
