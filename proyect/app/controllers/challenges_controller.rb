class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.includes(:tags, :participants, :owner)
                           .order(start_date: :desc)   # <- antes: starts_on
  end

  def show
    @challenge = Challenge.includes(:participants, :participations, :tags, :owner)
                          .find(params[:id])
  end
end


