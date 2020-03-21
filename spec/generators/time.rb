require "generative"
require "degenerate"

module TimeGenerator
  TIME_MIN = Time.at(0).utc
  TIME_MAX = Time.at(253402300799).utc

  def self.call(options = {})
    integer = Generative.generate(:integer, {
      min: options.fetch(:min, TIME_MIN).to_i,
      max: options.fetch(:max, TIME_MAX).to_i,
    })
    Time.at(integer).utc
  end
end

Generative.register_generator(:time, TimeGenerator)
