require "generative"
require "degenerate"

require_relative "time"

module DateGenerator
  DATE_MIN = TimeGenerator::TIME_MIN.to_date
  DATE_MAX = TimeGenerator::TIME_MAX.to_date

  def self.call(options = {})
    time = integer = Generative.generate(:time, {
      min: options.fetch(:min, DATE_MIN).to_time(:utc),
      max: options.fetch(:max, DATE_MAX).to_time(:utc),
    })
    time.to_date
  end
end

Generative.register_generator(:date, DateGenerator)
