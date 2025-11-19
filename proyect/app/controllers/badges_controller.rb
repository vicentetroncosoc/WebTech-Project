class BadgesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_badge, only: [:show, :edit, :update, :destroy]

  def index
    @badges = Badge.all
  end

  def show
  end

  def new
    @badge = Badge.new
    authorize! :create, @badge
  end

  def edit
    authorize! :update, @badge
  end

  def create
    @badge = Badge.new(badge_params)
    authorize! :create, @badge

    if @badge.save
      redirect_to @badge, notice: "Badge creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! :update, @badge

    if @badge.update(badge_params)
      redirect_to @badge, notice: "Badge actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @badge
    @badge.destroy
    redirect_to badges_path, notice: "Badge eliminado correctamente."
  end

  private

    def set_badge
      @badge = Badge.find(params[:id])
    end

    def badge_params
      params.require(:badge).permit(:name, :code, :description)
    end
end