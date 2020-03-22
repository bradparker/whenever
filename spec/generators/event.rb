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
      ends_at: ends_at,
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
    @id ||= options.fetch(:id, SecureRandom.uuid)
  end

  def title
    @title ||= Generative.generate(:string, options.fetch(:title, {}))
  end

  def starts_at
    @starts_at ||= Generative.generate(:time, options.fetch(:starts_at, {}))
  end

  def ends_at
    @ends_at ||= Generative.generate(:time, options.fetch(:ends_at, {
      min: starts_at,
    }))
  end

  def created_at
    @created_at ||= Generative.generate(:time, options.fetch(:created_at, {}))
  end

  def updated_at
    @updated_at ||= Generative.generate(:time, options.fetch(:updated_at, {
      min: created_at,
    }))
  end
end

Generative.register_generator(:event, EventGenerator)
