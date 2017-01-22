class Pet < ActiveRecord::Base
  validates_presence_of :name, :species, :color
  validates_uniqueness_of :name
  
  belongs_to :user
end