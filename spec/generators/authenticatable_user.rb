require "generative"
require "degenerate"

require_relative "user"

AuthenticatableUser = Struct.new(
  :user,
  :password
)

class AuthenticatableUserGenerator
  def self.call(options = {})
    new(options).call
  end

  def call
    AuthenticatableUser.new(
      user,
      password,
    )
  end

  private

  attr_reader :options

  def initialize(options = {})
    @options = options
  end

  def username
    @username ||= Generative.generate(:string, options.fetch(:username, {
      limit: 1000
    }))
  end

  def password
    @password ||= Generative.generate(:string, options.fetch(:password, {
      limit: 1000
    }))
  end

  def verifier
    @verifier ||= user_auth.fetch(:verifier)
  end

  def salt
    @salt ||= user_auth.fetch(:salt)
  end

  def user
    @user ||= Generative.generate(:user, options.fetch(:user, {}).merge({
      username: username,
      verifier: verifier,
      salt: salt
    }))
  end

  private

  def user_auth
    @user_auth ||= SIRP::Verifier.new(4096).generate_userauth(
      username,
      password,
    )
  end
end

Generative.register_generator(:authenticatable_user, AuthenticatableUserGenerator)
