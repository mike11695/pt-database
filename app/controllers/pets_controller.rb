class PetsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:edit, :update]
  before_action :only_current_user
  skip_before_action :only_current_user, only: [:update]
  
  # GET to /users/:user_id/pet/new
  def new
    @pet = Pet.new
  end
  
  # POST to /users/:user_id/pet
  def create
    # Ensure that we have the user  who is filling out form
    @user = User.find( params[:user_id] )
    # Create pet linked to this specific user or admin
    @pet = @user.pets.build( pet_params )
    if @pet.save
      flash[:success] = "Pet submitted!  It won't appear for you or other users until it is verified."
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  #GET to /users/:user_id/pet/edit
  def edit
    @user = User.find( params[:user_id] )
    @pet = Pet.find_by_id( params[:id] )
  end
  
  #PUT to /users/:user_id/pet/
  def update
    #Retrieve user from database
    @user = User.find( params[:user_id] )
    #Retrieve user's pet
    @pet = Pet.find(params[:pet][:id])
    #Mass assign edited pet attributes and save (update)
    if @pet.update_attributes(pet_params)
      flash[:success] = "Pet updated!"
      #Redirect user to profile page
      redirect_to user_path(id: params[:user_id] )
    else 
      render action: :edit
      Rails.logger.info(@pet.errors.messages.inspect)
    end
  end
  
  private
    def pet_params
      params.require(:pet).permit(:name, :color, :species, :level, :hp, :strength, :defence, :movement, :hsd, :uc, :rw, :rn, :verified, :description, :uft, :ufa, :gender, :id)
    end
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user || admin_signed_in?
    end
end