class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.order(:username)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Usuario creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Usuario actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Usuario eliminado."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  up = params.require(:user).permit(
    :username, :name, :email, :role, :avatar_url, :bio,
    :password, :password_confirmation
  )
  # Si viene password vacío (por ejemplo en editar), lo sacamos para no invalidar
  if up[:password].blank?
    up.except!(:password, :password_confirmation)
  end
  up
end


end


