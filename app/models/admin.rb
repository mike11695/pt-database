class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :terms, acceptance: true
  validates :age, acceptance: true
  validates :username, length: { maximum: 20 , too_long: " is too long, maximum is 20 characters" }, obscenity: true
  
         
  has_one :profile
         
  def email_required?
    false
  end

  def email_changed?
    false
  end
end