class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username, :email, :authorization
  validates_uniqueness_of :username, :email
  validates :username, length: { maximum: 20 , too_long: " is too long, maximum is 20 characters" }
  type_regex = /(r54XAda1427dDAerfc2571sffs54)/
  validates :authorization, format: { with: type_regex }
  
         
  has_one :profile
         
  def email_required?
    false
  end

  def email_changed?
    false
  end
end