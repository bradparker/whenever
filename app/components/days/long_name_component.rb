class Days::LongNameComponent < ViewComponent::Base
  def initialize(day:)
    @day = day
  end

  def name
    day.starts_at.strftime("%A, %-d %B %Y")
  end

  private

  attr_reader :day
end
