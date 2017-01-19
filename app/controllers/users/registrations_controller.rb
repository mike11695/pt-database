class Users::RegistrationsController < Devise::RegistrationsController
  
  def create
    params[:moderator] = 0
    resource.save
  end
  
end