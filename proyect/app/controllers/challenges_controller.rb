class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_challenge,        only: %i[show edit update destroy]
  before_action :set_form_collections, only: %i[new edit create update]


  def index
    @challenges = Challenge.includes(:tags, :participants, :owner)
                           .order(start_date: :desc)
  end

  def show
  end

  def new
    @challenge = Challenge.new(
      start_date: Date.today,
      end_date:   Date.today + 7.days,
      frequency:  "daily",
      points_per_entry: 1,
      max_entries_per_period: 1,
      is_approval_required: false,
      status: "draft"
    )
    authorize! :create, @challenge
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.owner = current_user
    authorize! :create, @challenge
    if @challenge.save
      redirect_to @challenge, notice: "Challenge creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @challenge
  end

  def update
    authorize! :update, @challenge
    if @challenge.update(challenge_params)
      redirect_to @challenge, notice: "Challenge actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @challenge
    @challenge.destroy
    redirect_to challenges_path, notice: "Challenge eliminado."
  end

  def join
    @challenge = Challenge.find(params[:id])
    # authorize! :create, Participation
    if @challenge.participations.exists?(user: current_user)
      redirect_to @challenge, alert: "Ya estás participando en este challenge."
    else
      @challenge.participations.create!(user: current_user)
      redirect_to @challenge, notice: "Te has unido al challenge."
    end
  end

  def leave
    @challenge = Challenge.find(params[:id])

    participation = @challenge.participations.find_by(user: current_user)
    # authorize! :destroy, participation || Participation

    if participation
      participation.destroy
      redirect_to @challenge, notice: "Has salido del challenge."
    else
      redirect_to @challenge, alert: "No estabas participando en este challenge."
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def set_form_collections
    @users = User.order(:username, :name).select(:id, :username, :name)
    @tags  = Tag.order(:name).select(:id, :name)
  end


  def challenge_params
    params.require(:challenge).permit(
      :name, :description, :start_date, :end_date, :owner_id, :category,
      :frequency, :points_per_entry, :max_entries_per_period,
      :is_approval_required, :status,
      tag_ids: [] # <-- importante para asignación masiva de tags
    )
  end

end

