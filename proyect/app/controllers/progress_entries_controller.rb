class ProgressEntriesController < ApplicationController
  before_action :set_progress_entry, only: %i[show edit update destroy]
  before_action :set_participations, only: %i[new edit create update]

  def index
    @progress_entries = ProgressEntry
                          .includes(participation: [:user, :challenge])
                          .order(created_at: :desc)
  end

  def show
  end

  def new
    @progress_entry = ProgressEntry.new(
      logged_on: Date.today,
      points_awarded: 0
    )
  end

  def create
    @progress_entry = ProgressEntry.new(progress_entry_params)
    if @progress_entry.save
      redirect_to @progress_entry, notice: "Registro de progreso creado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @progress_entry.update(progress_entry_params)
      redirect_to @progress_entry, notice: "Registro de progreso actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @progress_entry.destroy
    redirect_to progress_entries_path, notice: "Registro de progreso eliminado."
  end

  private

  def set_progress_entry
    @progress_entry = ProgressEntry.find(params[:id])
  end

  def set_participations
    # Para el <select>, mostramos "Usuario — Challenge"
    @participations = Participation
      .includes(:user, :challenge)
      .order("users.name NULLS LAST", "users.email", "challenges.name")
  end

  def progress_entry_params
    params.require(:progress_entry).permit(
      :participation_id, :logged_on, :quantity, :note, :points_awarded
    )
  end
end

