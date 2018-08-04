class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:verification, :edit, :update]
  
  def index
    if params[:unamesearch].present?
      @users = User.unamesearch(params[:unamesearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
    else
      @users = User.includes(:profile).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
    end
  end
  
  #This search function is super ugly, find a way to make it nicer
  def petindex
    @users = User.includes(:pet)
    
    if params[:namesearch].present?
      @pets = Pet.namesearch(params[:namesearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:colorsearch].present? && params[:speciessearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.speciessearch(params[:speciessearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      if params[:ucsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ucsearch].present? && params[:uftsearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
        @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ucsearch].present? && params[:ufasearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).order("created_at DESC")
        @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ucsearch].present?
        @pets = @pets.ucsearch(params[:colorsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      end
      
    elsif params[:colorsearch].present? && params[:ucsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.ucsearch(params[:ucsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      if params[:uftsearch].present? && params[:ufasearch].present?
        @pets = (@pets).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      end
      
    elsif params[:colorsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:colorsearch].present? && params[:uftsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:colorsearch].present? && params[:ufasearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).order("created_at DESC")
      @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:colorsearch].present?
      @pets = Pet.colorsearch(params[:colorsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:speciessearch].present? && params[:ucsearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.ucsearch(params[:ucsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      if params[:uftsearch].present? && params[:ufasearch].present?
        @pets = (@pets).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:uftsearch].present?
        @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      elsif params[:ufasearch].present?
        @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      end
      
    elsif params[:speciessearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:speciessearch].present? && params[:uftsearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:speciessearch].present? && params[:ufasearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).order("created_at DESC")
      @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:speciessearch].present?
      @pets = Pet.speciessearch(params[:speciessearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:ucsearch].present? && params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:ucsearch].present? && params[:uftsearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC") 
      @pets = @pets.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:ucsearch].present? && params[:ufasearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).order("created_at DESC") 
      @pets = @pets.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:ucsearch].present?
      @pets = Pet.ucsearch(params[:ucsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:uftsearch].present? && params[:ufasearch].present?
      @pets = Pet.includes(:user).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:uftsearch].present?
      @pets = Pet.uftsearch(params[:uftsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:ufasearch].present?
      @pets = Pet.ufasearch(params[:ufasearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:rwsearch].present? && params[:rnsearch].present?
      @rws = Pet.rwsearch(params[:rwsearch]).order("created_at DESC")
      @rns = Pet.rnsearch(params[:rnsearch]).order("created_at DESC")
      @pets = @rws + @rns
      
    elsif params[:rwsearch].present?
      @pets = Pet.rwsearch(params[:rwsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:rnsearch].present?
      @pets = Pet.rnsearch(params[:rnsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:minbdsearch].present? && params[:maxbdsearch].present?
      @pets = Pet.rangebdsearch(params[:minbdsearch], params[:maxbdsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:minbdsearch].present?
      @pets = Pet.minbdsearch(params[:minbdsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    elsif params[:maxbdsearch].present?
      @pets = Pet.maxbdsearch(params[:maxbdsearch]).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
      
    else
      @pets = Pet.includes(:user).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
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
    @pets = Pet.includes(:user).paginate(:page => params[:page], :per_page => 20).order("created_at DESC")
  end
  
  def edit
    @user = User.find( params[:id] )
  end
  
  #PUT to /users/
  def update
    #Retrieve user from database
    @user = User.find_by_id( params[:id] )
    #Mass assign edited profile attributes and save (update)
    if @user.update_attributes(user_params)
      flash[:success] = "User updated!"
      #Redirect user to profile page
      redirect_to user_path(id: params[:id] )
    else
      flash[:danger] = @user.errors.full_messages.join(", ")
      render action: :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end
  
  private
    def user_params
      params.require(:user).permit(:username, :banned)
    end
  
end