class PetsController < ApplicationController
  # GET to /users/:user_id/pet/new
  def new
    @pet = Pet.new
  end
end