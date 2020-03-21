class Months::LinkComponent < ViewComponent::Base
  attr_reader :month

  def initialize(month:)
    @month = month
  end
end
