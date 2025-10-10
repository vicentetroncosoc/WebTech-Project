class BadgesController < ApplicationController
  def index
    @badges = Badge.order(:name)
  end

  def show
    @badge = Badge.includes(:users).find(params[:id])
  end
end

