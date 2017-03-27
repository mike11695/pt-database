class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :banned?
  
  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been banned for violating site rules."
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :authorization, :terms, :age) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)}
  end
end
