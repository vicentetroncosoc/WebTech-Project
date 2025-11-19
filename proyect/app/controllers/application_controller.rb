class ApplicationController < ActionController::Base
  # Para que Devise permita campos extra en sign up / account edit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: "No tienes permiso para realizar esa acción."
  end

  protected

  def configure_permitted_parameters
    # Campos adicionales para registro
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:username, :name, :bio]
    )

    # Campos adicionales para editar cuenta
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:username, :name, :bio]
    )
  end
end