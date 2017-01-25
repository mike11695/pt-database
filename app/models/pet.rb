class Pet < ActiveRecord::Base
  validates_presence_of :name, :species, :color
  validates_uniqueness_of :name
  validates :description, length: { maximum: 500,
    too_long: "%{count} characters is the maximum allowed for descriptions." }
  
  belongs_to :user
end