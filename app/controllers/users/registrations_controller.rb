class Users::RegistrationsController < Devise::RegistrationsController
  #before_action :formCheck, only: :new
  
  #def create
      
  #end
  
  #private
  
  #def formCheck
      #unless( params[:username].nil? || params[:username] != 0 )
        #flash[:notice] = "Please select a username."
        #redirect_to new_user_registration_path
      #end
      #unless( params[:email].nil? || params[:email] != 0 )
        #flash[:notice] = "Please enter a email address."
        #redirect_to new_user_registration_path
      #end
  #end
end