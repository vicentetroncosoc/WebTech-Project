class ProgressEntriesController < ApplicationController
  def index
    @entries = ProgressEntry.includes(participation: [:user, :challenge]).order(created_at: :desc)
  end

  def show
    @entry = ProgressEntry.includes(participation: [:user, :challenge]).find(params[:id])
  end
end
