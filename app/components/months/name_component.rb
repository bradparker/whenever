class Months::NameComponent < ViewComponent::Base
  def initialize(month:)
    @month = month
  end

  def name
    month.starts_at.strftime("%B")
  end

  private

  attr_reader :month
end
