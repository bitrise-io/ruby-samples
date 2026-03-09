class UsersController < ApplicationController
  USERS_CACHE_KEY = "users/all"

  before_action :set_user, only: %i[show update destroy]

  def index
    users = Rails.cache.fetch(USERS_CACHE_KEY, expires_in: 1.hour) { User.all.to_a }
    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      WelcomeUserJob.perform_later(user)
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def user_params
    params.expect(user: %i[name email age])
  end
end
