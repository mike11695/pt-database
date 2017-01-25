class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:verification]
  
  def index
    @users = User.includes(:profile)
  end
  
  def petindex
    @users = User.includes(:pet)
    @pets = Pet.includes(:user)
    if params[:namesearch]
      @pets = Pet.namesearch(params[:namesearch]).order("created_at DESC")
    elsif params[:colorsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
    elsif params[:speciessearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
    elsif params[:ucsearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC")
    elsif params[:rwsearch].present?
      @pets = Pet.rwsearch(params[:rwsearch]).order("created_at DESC")
    elsif params[:rnsearch].present?
      @pets = Pet.rnsearch(params[:rnsearch]).order("created_at DESC")
    elsif params[:uftsearch].present?
      @pets = Pet.uftsearch(params[:uftsearch]).order("created_at DESC")
    elsif params[:ufasearch].present?
      @pets = Pet.ufasearch(params[:ufasearch]).order("created_at DESC")
    else
      @pets = Pet.includes(:user).order("created_at DESC")
    end
  end
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id] )
    @pets = Pet.includes(:user)
  end
  
  #Get to /pets/:id
  def petshow
    @pet = Pet.find( params[:id] )
  end
  
  def verification
    @users = User.includes(:pet)
    @pets = Pet.includes(:user)
  end
  
end