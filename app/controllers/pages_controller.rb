class PagesController < ApplicationController
    def home
      @pets = Pet.all
    end
    
    def about
    end
    
    def rules
    end
end