class PetsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :only_current_user
  skip_before_action :only_current_user, only: [:update]
  
  # GET to /users/:user_id/pet/new
  def new
    @user = User.find( params[:user_id] )
    @pet = Pet.new
  end
  
  # POST to /users/:user_id/pet
  def create
    # Ensure that we have the user  who is filling out form
    @user = User.find( params[:user_id] )
    # Create pet linked to this specific user or admin
    @pet = @user.pets.build( pet_params )
    
    # Add the other paramaters
    species_array = [['Acara', 1], ['Aisha', 2], ['Blumaroo', 3], 
      ['Bori', 4], ['Bruce', 5], ['Buzz', 6], ['Chia', 7], ['Chomby', 8], 
      ['Cybunny', 9], ['Draik', 10], ['Elephante', 11], ['Eyrie', 12], 
      ['Flotsam', 13], ['Gelert', 14], ['Gnorbu', 15], ['Grarrl', 16], 
      ['Grundo', 17], ['Hissi', 18], ['Ixi', 19], ['Jetsam', 20], ['Jubjub', 21], 
      ['Kacheek', 22], ['Kau', 23], ['Kiko', 24], ['Koi', 25], ['Korbat', 26], 
      ['Kougra', 27], ['Krawk', 28], ['Kyrii', 29], ['Lenny', 30], ['Lupe', 31], 
      ['Lutari', 32], ['Meerca', 33], ['Moehog', 34], ['Mynci', 35], 
      ['Nimmo', 36], ['Ogrin', 37], ['Peophin', 38], ['Poogle', 39], 
      ['Pteri', 40], ['Quiggle', 41], ['Ruki', 42], ['Scorchio', 43], 
      ['Shoyru', 44], ['Skeith', 45], ['Techo', 46], ['Tonu', 47], 
      ['Tuskaninny', 48], ['Uni', 49], ['Usul', 50], ['Vandagyre', 55], 
      ['Wocky', 51], ['Xweetok', 52], ['Yurble', 53], ['Zafara', 54]];
      
    colors_array = [['8-Bit', 92], ['Agueena', 101], ['Alien', 1], ['Apple', 2], 
      ['Asparagus', 3], ['Aubergine', 4], ['Avocado', 5], ['Baby', 6], ['Biscuit', 7], 
      ['Blue', 8], ['Blueberry', 9], ['Brown', 10], ['Camouflage', 11], ['Carrot', 12], 
      ['Checkered', 13], ['Chocolate', 14], ['Chokato', 15], ['Christmas', 16], 
      ['Clay', 17], ['Cloud', 18], ['Coconut', 19], ['Custard', 20], ['Darigan', 21], 
      ['Desert', 22], ['Dimensional', 100], ['Disco', 23], ['Durian', 24], 
      ['Elderlyboy', 97], ['Elderlygirl', 98], ['Electric', 25], ['Eventide', 96], 
      ['Faerie', 26], ['Fire', 27], ['Garlic', 28], ['Ghost', 29], ['Glowing', 30], 
      ['Gold', 31], ['Gooseberry', 32], ['Grape', 33], ['Green', 34], ['Grey', 35], 
      ['Halloween', 36], ['Ice', 37], ['Invisible', 38], ['Island', 39], ['Jelly', 40], 
      ['Lemon', 41], ['Lime', 42], ['Magma', 87], ['Mallow', 43], ['Maractite', 91], 
      ['Maraquan', 44], ['Msp', 45], ['Mutant', 46], ['Onion', 86], ['Orange', 47], 
      ['Pastel', 102], ['Pea', 48], ['Peach', 49], ['Pear', 50], ['Pepper', 51], 
      ['Pineapple', 52], ['Pink', 53], ['Pirate', 54], ['Plum', 55], ['Plushie', 56], 
      ['PolkaDot', 104], ['Purple', 57], ['Quigukiboy', 58], ['Quigukigirl', 59], 
      ['Rainbow', 60], ['Red', 61], ['Relic', 88], ['Robot', 62], ['Royalboy', 63], 
      ['Royalgirl', 64], ['Shadow', 65], ['Silver', 66], ['Sketch', 67], ['Skunk', 68], 
      ['Snot', 69], ['Snow', 70], ['Speckled', 71], ['Split', 72], ['Sponge', 73], 
      ['Spotted', 74], ['Starry', 75], ['Stealthy', 99], ['Strawberry', 76], 
      ['Striped', 77], ['SwampGas', 93], ['Thornberry', 78], ['Tomato', 79], 
      ['Transparent', 90], ['Tyrannian', 80], ['Ummagine', 103], ['UsukiBoy', 81], 
      ['UsukiGirl', 82], ['Water', 94], ['White', 83], ['Woodland', 89], ['Wraith', 95], 
      ['Yellow', 84], ['Zombie', 85], ['Candy', 105], ['Marble', 106], 
      ['Steampunk', 107], ['Toy', 108], ['Origami', 109]];
    
    require 'net/http'
    require 'json'
    
    url = "http://www.neopets.com/amfphp/json.php/CustomPetService.getViewerData/" + @pet.name
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    
    if data["error"]
      flash[:danger] = "That pet does not exist!"
      render action: :new
    else
      if data["custom_pet"]["biology_by_zone"]["46"]
        @pet.uc = true;
      end
      
      species_array.each do |species|
        id = species[1]
        if id == data["custom_pet"]["species_id"]
          @pet.species = species[0]
        end
      end
      
      colors_array.each do |color|
        id = color[1]
        if id == data["custom_pet"]["color_id"]
          @pet.color = color[0]
        end
      end
      
      # so name is formatted correctly as it appears on site
      @pet.name = data["custom_pet"]["name"]
      
      if @pet.hp == nil
        @pet.hp = 0
      end
      if @pet.strength == nil
        @pet.strength = 0
      end
      if @pet.defence == nil
        @pet.defence = 0
      end
      if @pet.movement == nil
        @pet.movement = 0
      end
      
      # set the hsd
      if @pet.strength > 750 && @pet.defence > 750
        @pet.hsd = @pet.hp + 750 + 750
      elsif @pet.strength > 750
        @pet.hsd = @pet.hp + 750 + @pet.defence
      elsif @pet.defence > 750
        @pet.hsd = @pet.hp + 750 + @pet.strength
      else
        @pet.hsd =  @pet.hp + @pet.defence + @pet.strength
      end
      
      if @pet.save
        flash[:success] = "Pet submitted!  It won't appear for other users until it is verified."
        redirect_to user_path( params[:user_id] )
      else
        flash[:danger] = @pet.errors.full_messages.join(", ")
        render action: :new
      end
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
    
    # Add the other paramaters
    species_array = [['Acara', 1], ['Aisha', 2], ['Blumaroo', 3], 
      ['Bori', 4], ['Bruce', 5], ['Buzz', 6], ['Chia', 7], ['Chomby', 8], 
      ['Cybunny', 9], ['Draik', 10], ['Elephante', 11], ['Eyrie', 12], 
      ['Flotsam', 13], ['Gelert', 14], ['Gnorbu', 15], ['Grarrl', 16], 
      ['Grundo', 17], ['Hissi', 18], ['Ixi', 19], ['Jetsam', 20], ['Jubjub', 21], 
      ['Kacheek', 22], ['Kau', 23], ['Kiko', 24], ['Koi', 25], ['Korbat', 26], 
      ['Kougra', 27], ['Krawk', 28], ['Kyrii', 29], ['Lenny', 30], ['Lupe', 31], 
      ['Lutari', 32], ['Meerca', 33], ['Moehog', 34], ['Mynci', 35], 
      ['Nimmo', 36], ['Ogrin', 37], ['Peophin', 38], ['Poogle', 39], 
      ['Pteri', 40], ['Quiggle', 41], ['Ruki', 42], ['Scorchio', 43], 
      ['Shoyru', 44], ['Skeith', 45], ['Techo', 46], ['Tonu', 47], 
      ['Tuskaninny', 48], ['Uni', 49], ['Usul', 50], ['Vandagyre', 55], 
      ['Wocky', 51], ['Xweetok', 52], ['Yurble', 53], ['Zafara', 54]];
      
    colors_array = [['8-Bit', 92], ['Agueena', 101], ['Alien', 1], ['Apple', 2], 
      ['Asparagus', 3], ['Aubergine', 4], ['Avocado', 5], ['Baby', 6], ['Biscuit', 7], 
      ['Blue', 8], ['Blueberry', 9], ['Brown', 10], ['Camouflage', 11], ['Carrot', 12], 
      ['Checkered', 13], ['Chocolate', 14], ['Chokato', 15], ['Christmas', 16], 
      ['Clay', 17], ['Cloud', 18], ['Coconut', 19], ['Custard', 20], ['Darigan', 21], 
      ['Desert', 22], ['Dimensional', 100], ['Disco', 23], ['Durian', 24], 
      ['Elderlyboy', 97], ['Elderlygirl', 98], ['Electric', 25], ['Eventide', 96], 
      ['Faerie', 26], ['Fire', 27], ['Garlic', 28], ['Ghost', 29], ['Glowing', 30], 
      ['Gold', 31], ['Gooseberry', 32], ['Grape', 33], ['Green', 34], ['Grey', 35], 
      ['Halloween', 36], ['Ice', 37], ['Invisible', 38], ['Island', 39], ['Jelly', 40], 
      ['Lemon', 41], ['Lime', 42], ['Magma', 87], ['Mallow', 43], ['Maractite', 91], 
      ['Maraquan', 44], ['Msp', 45], ['Mutant', 46], ['Onion', 86], ['Orange', 47], 
      ['Pastel', 102], ['Pea', 48], ['Peach', 49], ['Pear', 50], ['Pepper', 51], 
      ['Pineapple', 52], ['Pink', 53], ['Pirate', 54], ['Plum', 55], ['Plushie', 56], 
      ['PolkaDot', 104], ['Purple', 57], ['Quigukiboy', 58], ['Quigukigirl', 59], 
      ['Rainbow', 60], ['Red', 61], ['Relic', 88], ['Robot', 62], ['Royalboy', 63], 
      ['Royalgirl', 64], ['Shadow', 65], ['Silver', 66], ['Sketch', 67], ['Skunk', 68], 
      ['Snot', 69], ['Snow', 70], ['Speckled', 71], ['Split', 72], ['Sponge', 73], 
      ['Spotted', 74], ['Starry', 75], ['Stealthy', 99], ['Strawberry', 76], 
      ['Striped', 77], ['SwampGas', 93], ['Thornberry', 78], ['Tomato', 79], 
      ['Transparent', 90], ['Tyrannian', 80], ['Ummagine', 103], ['UsukiBoy', 81], 
      ['UsukiGirl', 82], ['Water', 94], ['White', 83], ['Woodland', 89], ['Wraith', 95], 
      ['Yellow', 84], ['Zombie', 85], ['Candy', 105], ['Marble', 106], 
      ['Steampunk', 107], ['Toy', 108], ['Origami', 109]];
    
    require 'net/http'
    require 'json'
    
    # using params in case later we decide users can update an old pet with a different pet
    url = "http://www.neopets.com/amfphp/json.php/CustomPetService.getViewerData/" + @pet.name
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    
    if data["error"]
      flash[:danger] = "That pet does not exist!"
      render action: :new
    else
      if data["custom_pet"]["biology_by_zone"]["46"]
        @pet.uc = true;
      else
        @pet.uc = false;
      end
      
      species_array.each do |species|
        id = species[1]
        if id == data["custom_pet"]["species_id"]
          @pet.species = species[0]
        end
      end
      
      colors_array.each do |color|
        id = color[1]
        if id == data["custom_pet"]["color_id"]
          @pet.color = color[0]
        end
      end
      
      # so name is formatted correctly as it appears on site
      @pet.name = data["custom_pet"]["name"]
      
      if @pet.update_attributes(pet_params)
        if @pet.hp == nil
          @pet.hp = 0
        end
        if @pet.strength == nil
          @pet.strength = 0
        end
        if @pet.defence == nil
          @pet.defence = 0
        end
        if @pet.movement == nil
          @pet.movement = 0
        end
        
        # set the hsd
        if @pet.strength > 750 && @pet.defence > 750
          @pet.hsd = @pet.hp + 750 + 750
        elsif @pet.strength > 750
          @pet.hsd = @pet.hp + 750 + @pet.defence
        elsif @pet.defence > 750
          @pet.hsd = @pet.hp + 750 + @pet.strength
        else
          @pet.hsd =  @pet.hp + @pet.defence + @pet.strength
        end
        
        if @pet.update_attributes(pet_params)
          flash[:success] = "Pet updated!"
          #Redirect user to pet profile page
          redirect_to controller: "users", action: "petshow", id: @pet.id
        else 
          render action: :edit
          Rails.logger.info(@pet.errors.messages.inspect)
        end
      else 
        render action: :edit
        Rails.logger.info(@pet.errors.messages.inspect)
      end
    end
  end
  
  def destroy
    Pet.find(params[:id]).destroy
    flash[:success] = "Pet deleted."
    redirect_to user_path( params[:user_id] )
  end
  
  private
    def pet_params
      params.require(:pet).permit(:name, :color, :species, :level, :hp, :strength, :defence, :movement, :hsd, :uc, :rw, :rn, :verified, :description, :uft, :ufa, :gender, :id, :agreement)
    end
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user || admin_signed_in?
    end
end