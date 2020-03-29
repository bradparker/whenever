module Authentication
  class ProofsController < ApplicationController
    def create
      user = User.find_by!(username: proof_params[:username])
      server_H_AMK = verifier.verify_session(user.proof, proof_params[:M])

      if server_H_AMK.blank?
        render status: :unauthorized, json: { message: "Unauthorized" }
      else
        render status: :ok, json: { H_AMK: server_H_AMK }
      end
    end

    private

    def proof_params
      params.require(:proof).permit(:username, :M)
    end

    def verifier
      @verifier ||= SIRP::Verifier.new(4096) # prime length
    end
  end
end
