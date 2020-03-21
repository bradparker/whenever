class Days::LinkComponent < ViewComponent::Base
  attr_reader :day

  def initialize(day:)
    @day = day
  end
end
