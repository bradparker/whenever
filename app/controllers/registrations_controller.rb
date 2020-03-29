class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render(
        status: :created,
        json: @user.slice(
          :username,
          :salt,
          :verifier,
          :created_at,
          :updated_at
        )
      )
    else
      render(
        status: :unprocessable_entity,
        json: @user.errors
      )
    end
  end

  def show
    @user = User.find_by!(username: params[:username])
    render(
      status: :ok,
      json: @user.slice(
        :username,
        :salt,
        :verifier,
        :created_at,
        :updated_at
      )
    )
  end

  private

  def user_params
    params.require(:user).permit(:username, :salt, :verifier)
  end
end
