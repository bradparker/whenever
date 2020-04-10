class RegistrationsController < ApplicationController
  skip_before_action :authorize!, except: [:edit, :update]

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
          :time_zone,
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
        :time_zone,
        :salt,
        :verifier,
        :created_at,
        :updated_at
      )
    )
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_update_params)
      flash[:notice] = "Settings updated"
      redirect_to settings_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :time_zone, :salt, :verifier)
  end

  def user_update_params
    params.require(:user).permit(:username, :time_zone)
  end
end
