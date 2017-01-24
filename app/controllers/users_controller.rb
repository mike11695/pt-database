class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:verification]
  
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
    @pets = Pet.includes(:user)
  end
  
  def petshow
    @pet = Pet.find( params[:id] )
  end
  
  def verification
    @users = User.includes(:pet)
    @pets = Pet.includes(:user)
  end
  
end