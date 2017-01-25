class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :username, length: { maximum: 20 , too_long: "%{count} is too long, maximum is 20 characters" }
  
  has_one :profile
  has_many :pets
         
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
