class UsersController < ApplicationController
  def index
    @users = User.includes(:badges).order(:name)
  end

  def show
    @user = User.includes(:owned_challenges, :badges, :participations, :challenges).find(params[:id])
  end
end


