class ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:edit, :update]
  before_action :only_current_user
  skip_before_action :only_current_user, only: [:edit, :update]
  
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user or admin who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user or admin
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      flash[:danger] = @profile.errors.full_messages.join(", ")
      render action: :new
    end
  end
  
  #GET to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  #PUT to /users/:user_id/profile/
  def update
    #Retrieve user from database
    @user = User.find( params[:user_id] )
    #Retrieve user's profile
    @profile = @user.profile
    #Mass assign edited profile attributes and save (update)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      #Redirect user to profile page
      redirect_to user_path(id: params[:user_id] )
    else 
      flash[:danger] = @profile.errors.full_messages.join(", ")
      render action: :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:avatar, :description, :neoname)
    end
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end