class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[show edit update destroy]
  before_action :set_users_and_challenges, only: %i[new edit create update]

  def index
    @participations = Participation
                        .includes(:user, :challenge)
                        .order(created_at: :desc)
  end

  def show
  end

  def new
    @participation = Participation.new(
      role: "participant",
      state: "active",
      joined_at: Time.current
    )
  end

  def create
    @participation = Participation.new(participation_params)
    if @participation.save
      redirect_to @participation, notice: "Participación creada correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @participation.update(participation_params)
      redirect_to @participation, notice: "Participación actualizada."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @participation.destroy
    redirect_to participations_path, notice: "Participación eliminada."
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end

  def set_users_and_challenges
    @users = User.order(:name, :email).select(:id, :name, :email, :username)
    @challenges = Challenge.order(:name).select(:id, :name, :start_date, :end_date)
  end

  def participation_params
    params.require(:participation).permit(
      :user_id, :challenge_id, :role, :state, :joined_at, :left_at, :total_points
    )
  end
end
