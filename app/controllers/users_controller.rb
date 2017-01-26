class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:verification]
  
  def index
    @users = User.includes(:profile)
  end
  
  #This search function is super ugly, find a way to make it nicer
  def petindex
    @users = User.includes(:pet)
    
    if params[:namesearch].present?
      @pets = Pet.namesearch(params[:namesearch]).order("created_at DESC")
      
    elsif params[:colorsearch].present? && params[:speciessearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.speciessearch(params[:speciessearch]).order("created_at DESC")
      if params[:ucsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
        @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
        @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
        @pets = @ufts + @ufas
      elsif params[:ucsearch].present? && params[:uftsearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
        @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      elsif params[:ucsearch].present? && params[:ufasearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
        @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      elsif params[:ucsearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      end
      
    elsif params[:colorsearch].present? && params[:ucsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.ucsearch(params[:ucsearch]).order("created_at DESC")
      if params[:uftsearch].present? && params[:ufasearch].present?
        @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
        @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
        @pets = @ufts + @ufas
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      end
      
    elsif params[:colorsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      @pets = @ufts + @ufas
      
    elsif params[:colorsearch].present? && params[:uftsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      
    elsif params[:colorsearch].present? && params[:ufasearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      
    elsif params[:colorsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      
    elsif params[:speciessearch].present? && params[:ucsearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.ucsearch(params[:ucsearch]).order("created_at DESC")
      if params[:uftsearch].present? && params[:ufasearch].present?
        @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
        @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
        @pets = @ufts + @ufas
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      end
      
    elsif params[:speciessearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      @pets = @ufts + @ufas
      
    elsif params[:speciessearch].present? && params[:uftsearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      
    elsif params[:speciessearch].present? && params[:ufasearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      
    elsif params[:speciessearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      
    elsif params[:ucsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC") 
      @ufts = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      @ufas = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      @pets = @ufts + @ufas
      
    elsif params[:ucsearch].present? && params[:uftsearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC") 
      @pets = @pets.uftsearch(params[:uftsearch]).order("created_at DESC")
      
    elsif params[:ucsearch].present? && params[:ufasearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC") 
      @pets = @pets.ufasearch(params[:ufasearch]).order("created_at DESC")
      
    elsif params[:ucsearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC")
      
    elsif params[:uftsearch].present? && params[:ufasearch].present?
      @ufts = Pet.uftsearch(params[:uftsearch]).order("created_at DESC")
      @ufas = Pet.ufasearch(params[:ufasearch]).order("created_at DESC")
      @pets = @ufts + @ufas
      
    elsif params[:uftsearch].present?
      @pets = Pet.uftsearch(params[:uftsearch]).order("created_at DESC")
      
    elsif params[:ufasearch].present?
      @pets = Pet.ufasearch(params[:ufasearch]).order("created_at DESC")
      
    elsif params[:rwsearch].present? && params[:rnsearch].present?
      @rws = Pet.rwsearch(params[:rwsearch]).order("created_at DESC")
      @rns = Pet.rnsearch(params[:rnsearch]).order("created_at DESC")
      @pets = @rws + @rns
      
    elsif params[:rwsearch].present?
      @pets = Pet.rwsearch(params[:rwsearch]).order("created_at DESC")
      
    elsif params[:rnsearch].present?
      @pets = Pet.rnsearch(params[:rnsearch]).order("created_at DESC")
      
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