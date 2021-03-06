class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index
    @users = User.all.map{|user| {
      id: user.id,
      username: user.username,
      trips: user.trips,
      attractions: user.trips.map{|trip| trip.attractions},
      locations: user.locations
      }
    }
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: {
      id: @user.id,
      name: @user.name,
      trips: user.trips,
      attractions: user.trips.map{|trip| trip.attractions},
      locations: @user.locations
    }
  end

  def profile
    render json: { user: current_user }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: @user, jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
