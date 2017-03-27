class PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    flash[:success] = "An email with instructions on resetting your password have been sent to you."
  end
end