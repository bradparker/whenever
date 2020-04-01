require "generative"
require "degenerate"

require_relative "time"

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
    @username ||= options.fetch(:username, Generative.generate(:string, {
      limit: 1000
    }))
  end

  def salt
    @salt ||= options.fetch(:salt, SecureRandom.hex(1024))
  end

  def verifier
    @verifier ||= options.fetch(:verifier, SecureRandom.hex(1024))
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
