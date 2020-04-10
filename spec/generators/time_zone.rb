require "generative"

module TimeZoneGenerator
  def self.call
    ActiveSupport::TimeZone.all.sample
  end
end

Generative.register_generator(:time_zone, TimeZoneGenerator)
