class Api::V1::UsersController < ApplicationController
  respond_to :json
  wrap_parameters :user, include: [:email, :password, :password_confirmation]

  def show
    begin
      @user = User.find(params[:id])
      respond_with @user
    rescue
      head :not_found
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
