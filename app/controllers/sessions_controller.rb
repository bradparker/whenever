class SessionsController < ApplicationController
  skip_before_action :authorize!

  def new
  end

  def create
    user = User.find_by!(username: session_params[:username])
    challenge_and_proof = verifier.get_challenge_and_proof(
      user.username,
      user.verifier,
      user.salt,
      session_params[:A]
    )
    session = Session.create!(
      user_id: user.id,
      proof: challenge_and_proof[:proof],
      verified: false
    )
    render(
      :ok,
      json: {
        id: session.id,
        salt: challenge_and_proof.dig(:challenge, :salt),
        B: challenge_and_proof.dig(:challenge, :B)
      }
    )
  end

  def verify
    session = Session.find(params[:id])
    server_H_AMK = verifier.verify_session(session.proof, proof_params[:M])

    if server_H_AMK.blank?
      render status: :unauthorized, json: { message: "Unauthorized" }
    else
      session.update!(verified: true)
      render status: :ok, json: { H_AMK: server_H_AMK }
    end
  end

  private

  def session_params
    params.require(:session).permit(:username, :A)
  end

  def proof_params
    params.require(:proof).permit(:M)
  end
end
