class TimeZoneSelectComponent < ViewComponent::Base
  attr_reader :value, :classes, :name

  def initialize(options = {})
    @value = options.fetch(:value, "")
    @name = options.fetch(:name, "")
    @classes = options.fetch(:class, "")
  end

  def timezones
    ActiveSupport::TimeZone.all
  end
end
