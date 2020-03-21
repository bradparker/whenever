class Months::LongNameComponent < ViewComponent::Base
  def initialize(month:)
    @month = month
  end

  def name
    month.starts_at.strftime("%B, %Y")
  end

  private

  attr_reader :month
end
