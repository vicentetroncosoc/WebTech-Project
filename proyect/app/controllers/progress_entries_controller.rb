class ProgressEntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_progress_entry, only: %i[ show edit update destroy ]
  before_action :set_participations, only: %i[ new edit create update ]

  # GET /progress_entries or /progress_entries.json
  def index
    if current_user.admin?
      @progress_entries = ProgressEntry.includes(participation: [:user, :challenge]).all

    elsif current_user.creator?
      # Participations de challenges que él creó
      creator_challenge_ids = current_user.owned_challenges.pluck(:id)
      creator_participation_ids = Participation.where(challenge_id: creator_challenge_ids).pluck(:id)

      # + participations propias
      own_participation_ids = current_user.participations.pluck(:id)

      ids = (creator_participation_ids + own_participation_ids).uniq

      @progress_entries = ProgressEntry
                            .includes(participation: [:user, :challenge])
                            .where(participation_id: ids)

    else
      # Standard: solo sus entradas
      @progress_entries = current_user.progress_entries
                                      .includes(participation: [:user, :challenge])
    end
  end

  # GET /progress_entries/new
  def new
    @progress_entry = ProgressEntry.new
  end

  # POST /progress_entries
  def create
    @progress_entry = ProgressEntry.new(progress_entry_params)

    # Seguridad extra: que la participation pertenezca al set permitido
    unless @participations.any? { |p| p.id == @progress_entry.participation_id.to_i }
      return redirect_to new_progress_entry_path,
                        alert: "No puedes asignar progreso a esa participación."
  end

    respond_to do |format|
      if @progress_entry.save
        format.html { redirect_to progress_entry_url(@progress_entry), notice: "Progress entry was successfully created." }
        format.json { render :show, status: :created, location: @progress_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @progress_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /progress_entries/1/edit
  def edit
  end

  # PATCH/PUT /progress_entries/1
  def update
    # Seguridad extra: que la participation elegida siga siendo válida
    participation_id = params[:progress_entry][:participation_id].to_i

    unless @participations.any? { |p| p.id == participation_id }
      return redirect_to edit_progress_entry_path(@progress_entry),
                        alert: "No puedes asignar progreso a esa participación."
  end

    respond_to do |format|
      if @progress_entry.update(progress_entry_params)
        format.html { redirect_to progress_entry_url(@progress_entry), notice: "Progress entry was successfully updated." }
        format.json { render :show, status: :ok, location: @progress_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @progress_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progress_entries/1
  def destroy
    @progress_entry.destroy!

    respond_to do |format|
      format.html { redirect_to progress_entries_url, notice: "Progress entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_progress_entry
      @progress_entry = ProgressEntry.find(params[:id])
    end

    # Participations disponibles según rol (se usa en el form)
    def set_participations
      if current_user.admin?
        @participations = Participation.includes(:user, :challenge).all

      elsif current_user.creator?
        # Challenges que creó el usuario
        creator_challenge_ids = current_user.owned_challenges.pluck(:id)

        # Participaciones en sus challenges
        creator_participations = Participation
                                  .includes(:user, :challenge)
                                  .where(challenge_id: creator_challenge_ids)

        # Participaciones propias
        own_participations = current_user.participations.includes(:user, :challenge)

        # Unión sin duplicados
        @participations = (creator_participations + own_participations).uniq

      else
        # Standard: solo sus participations
        @participations = current_user.participations.includes(:user, :challenge)
      end
    end

    # Solo permitir parámetros válidos
    def progress_entry_params
      params.require(:progress_entry).permit(
        :participation_id,
        :logged_on,
        :quantity,
        :points_awarded,
        :note
      )
    end
end