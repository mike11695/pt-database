class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :terms, acceptance: true
  validates :age, acceptance: true
  validates :username, length: { maximum: 20 , too_long: "%{count} is too long, maximum is 20 characters" }, 
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "can only have numbers and letters." }, obscenity: true
    
  before_destroy :destroy_everything
  
  has_one :profile
  has_many :pets
  
  def self.unamesearch(unamesearch)
    where("username LIKE ?", "%#{unamesearch}%") 
  end
         
  def email_required?
    false
  end

  def email_changed?
    false
  end
  
  self.per_page = 20
  
  private
  
  def destroy_everything
    self.pets.destroy_all
  end
end
