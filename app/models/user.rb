class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
         
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
