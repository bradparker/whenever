class Weeks::LongNameComponent < ViewComponent::Base
  def initialize(week:)
    @week = week
  end

  def name
    "Week #{week.value}, #{week.year.value}"
  end

  private

  attr_reader :week
end
