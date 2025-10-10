class UserBadgesController < ApplicationController
  def index
    @user_badges = UserBadge.includes(:user, :badge).order(created_at: :desc)
  end

  def show
    @user_badge = UserBadge.includes(:user, :badge).find(params[:id])
  end
end

