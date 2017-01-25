class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar,
                    :styles => { :medium => "300x300", :thumb => "100x100" },
                    :default_url => "images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :description, length: { maximum: 500,
    too_long: "%{count} characters is the maximum allowed for descriptions." }
  validates :title, length: { maximum: 50,
    too_long: "%{count} characters is the maximum allowed for titles." }
end