class ParticipationsController < ApplicationController
  def index
    @participations = Participation.includes(:user, :challenge).order(created_at: :desc)
  end

  def show
    @participation = Participation.includes(:user, :challenge, :progress_entries).find(params[:id])
  end
end
