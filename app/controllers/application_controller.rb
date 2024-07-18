class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_redirect_to, :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    stored_location = session[:redirect_to]
    session.delete(:redirect_to)
    stored_location || root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :remember_me])
  end

  private

  def store_redirect_to
    session[:redirect_to] = params[:redirect_to] if params[:redirect_to].present?
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
