module Authentication
  class ChallengesController < ApplicationController
    def create
      if challenge_params[:A].blank?
        render(
          status: :unprocessable_entity,
          json: { A: ["cannot be blank"] }
        )
      else
        user = User.find_by!(username: challenge_params[:username])
        session = verifier.get_challenge_and_proof(
          user.username,
          user.verifier,
          user.salt,
          challenge_params[:A]
        )
        user.proof = session[:proof]
        user.save!
        render :ok, json: session[:challenge]
      end
    end

    private

    def challenge_params
      params.require(:challenge).permit(:username, :A)
    end

    def verifier
      @verifier ||= SIRP::Verifier.new(4096) # prime length
    end
  end
end
