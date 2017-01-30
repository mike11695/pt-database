class Contact < ActiveRecord::Base
  # Contact form validations
  validates :name, presence: true, length: { maximum: 100 , too_long: "%{count} is too long, maximum is 100 characters" }, obscenity: true
  validates :email, presence: true, length: { maximum: 100 , too_long: "%{count} is too long, maximum is 100 characters" }, obscenity: true
  validates :comments, presence: true, length: { maximum: 500 , too_long: "%{count} is too long, maximum is 500 characters" }, obscenity: true
end