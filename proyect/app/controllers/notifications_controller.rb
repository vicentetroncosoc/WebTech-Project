class NotificationsController < ApplicationController
  def index
    @notifications = Notification.includes(:user).order(created_at: :desc)
  end

  def show
    @notification = Notification.find(params[:id])
  end
end
