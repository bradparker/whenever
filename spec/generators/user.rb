require "generative"
require "degenerate"

require_relative "bounded_string"
require_relative "time"
require_relative "time_zone"

class UserGenerator
  def self.call(options = {})
    new(options).call
  end

  def call
    User.new(
      id: id,
      username: username,
      salt: salt,
      verifier: verifier,
      time_zone: time_zone,
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

  def username
    @username ||= options.fetch(:username, Generative.generate(:bounded_string, {
      min: 1,
      max: 1000,
    }))
  end

  def salt
    @salt ||= options.fetch(:salt, SecureRandom.hex(1024))
  end

  def verifier
    @verifier ||= options.fetch(:verifier, SecureRandom.hex(1024))
  end

  def time_zone
    @time_zone ||= options.fetch(
      :time_zone,
      Generative.generate(:time_zone).tzinfo.identifier
    )
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

Generative.register_generator(:user, UserGenerator)
