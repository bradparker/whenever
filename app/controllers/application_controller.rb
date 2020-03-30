# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize!

  private

  def authorize!
    unless load_verified_session
      redirect_to sign_in_path
    end
  end

  def load_verified_session
    session = Session.find_by(id: cookies[:SID], verified: true)
    return unless session.present?

    server_H_AMK = verifier.verify_session(session.proof, cookies[:SM])
    return unless server_H_AMK.present?

    @session = session
  end

  def verifier
    @verifier ||= SIRP::Verifier.new(4096) # prime length
  end

  def current_user
    @current_user ||= @session.user
  end
end
