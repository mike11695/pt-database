class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.includes(:profile)
  end
  
  def petindex
    @users = User.includes(:pet)
    @pets = Pet.includes(:user)
  end
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
  end
  
  def petshow
    @pet = Pet.find( params[:id] )
  end
  
end