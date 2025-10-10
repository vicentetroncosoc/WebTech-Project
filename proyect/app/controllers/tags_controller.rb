class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
    @challenges = @tag.challenges.includes(:owner, :participants)
  end
end

