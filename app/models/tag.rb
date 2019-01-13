class Tag < ApplicationRecord
  has_many :taggings
  has_many :pets, through: :taggings
end
