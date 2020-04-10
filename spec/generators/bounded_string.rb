require "generative"

class BoundedStringGenerator
  def self.call(options)
    new(options).call
  end

  def initialize(options)
    @options = options
  end

  def call
    Array.new(length) { chars.sample }.join
  end

  private

  attr_reader :options

  def length
    @length ||= Generative.generate(:integer, {
      min: options.fetch(:min, 0),
      max: options.fetch(:max, 9999)
    })
  end

  def chars
    @chars ||= ('1'..'z').to_a
  end
end

Generative.register_generator(:bounded_string, BoundedStringGenerator)
