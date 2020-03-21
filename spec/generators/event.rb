require "generative"
require "degenerate"

require_relative "time"

class EventGenerator
  def self.call(options = {})
    new(options).call
  end

  def call
    Event.new(
      id: id,
      title: title,
      starts_at: starts_at,
      duration: duration,
      created_at: created_at,
      updated_at: updated_at,
    )
  end

  private

  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def id
    options.fetch(:id, SecureRandom.uuid)
  end

  def title
    Generative.generate(:string, options.fetch(:title, {}))
  end

  def starts_at
    Generative.generate(:time, options.fetch(:starts_at, {}))
  end

  def duration
    Generative.generate(:integer, options.fetch(:duration, {
      min: 0,
      max: 2_147_483_647,
    }))
  end

  def created_at
    Generative.generate(:time, options.fetch(:created_at, {}))
  end

  def updated_at
    Generative.generate(:time, options.fetch(:updated_at, {
      min: created_at,
    }))
  end
end

Generative.register_generator(:event, EventGenerator)
