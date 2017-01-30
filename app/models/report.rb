class Report < ActiveRecord::Base
  # Report form validations
  validates :name, presence: true, length: { maximum: 100 , too_long: "%{count} is too long, maximum is 20 characters" }, obscenity: true
  validates :issue, presence: true
  validates :body, presence: true, length: { maximum: 500 , too_long: "%{count} is too long, maximum is 500 characters" }, obscenity: true
end