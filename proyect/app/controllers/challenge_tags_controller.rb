class ChallengeTagsController < ApplicationController
  def index
    @challenge_tags = ChallengeTag.includes(:challenge, :tag).order(created_at: :desc)
  end
  def show
    @challenge_tag = ChallengeTag.includes(:challenge, :tag).find(params[:id])
  end
end
